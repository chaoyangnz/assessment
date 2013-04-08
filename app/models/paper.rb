class Paper < ActiveRecord::Base
  set_inheritance_column ''

  TYPES = %w[general partial]
  LANGUAGES = %w[Japanese]
  PURPOSES = %w[assess test]
  STATUS = %w[draft public]

  def draft?
    status == 'draft'
  end

  def public?
    status == 'public'
  end

  def general?
    type == 'general'
  end

  def partial?
    type == 'partial'
  end

  def top_leaf?
    general? && !has_parts?
  end


  attr_accessible :type, :name, :notice, :score, :duration,
                  :language, :purpose, :has_parts

  belongs_to :general_paper, :class_name => 'Paper', :foreign_key => 'paper_id'
  has_many :partial_papers, :class_name => 'Paper'

  has_many :nodes

  def questions
    if partial?
      nodes.where(:depth => 1).order('weight asc').map {|node| node.material? ? node.questions.order('weight asc') : node }.flatten
    else
      partial_papers.map {|part| part.questions }.inject(:+)
    end
  end
end
