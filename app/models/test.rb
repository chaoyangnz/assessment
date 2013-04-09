class Test < ActiveRecord::Base
  #attr_accessible :mode

  belongs_to :user
  belongs_to :paper

  has_many :solutions

  after_create :create_solutions

  def handed_in?
    ! ended_at.blank?
  end

  def expired?
    ! handed_in? && (Time.now - started_at - 30)/60 > paper.duration # 30秒交卷时间
  end

  def completed?
    handed_in? || expired?
  end

  def question_solution(question)
    if question.class == Node
      solutions.where(:node_id => question.id).first
    else
      solutions.where(:node_id => question).first
    end
  end

  def index(question)
    questions =  paper.questions
    index = questions.index { |q| q.id == question.id }
  end

  def next_question(question)
    questions.at(index(question))
  end

  def compute_score
      score = {}
      if paper.has_parts?
        paper.partial_papers.each do |part|
          grades = Test.connection.select_all("select a.grade from nodes a, solutions b, choices c where a.id=c.node_id and a.id=c.node_id and c.is_answer=1 and b.answer=c.id and a.type='question' and a.paper_id=#{part.id} and b.test_id=#{id}")
          score[part.id] = grades.reduce(0) { |sum, grade| sum + grade['grade'] }
        end
      else
        grades = Test.connection.select_all("select a.grade from nodes a, solutions b, choices c where a.id=c.node_id and a.id=c.node_id and c.is_answer=1 and b.answer=c.id and a.type='question' and a.paper_id=#{paper.id} and b.test_id=#{id}")
        score[part.id] = grades.reduce(0) { |sum, grade| sum + grade['grade'] }
      end

      score
  end

  private
  # placeholder
  def create_solutions
    paper.questions.each do |question|
      solution = Solution.new
      solution.test = self
      solution.question = question

      solution.save
    end
  end
end
