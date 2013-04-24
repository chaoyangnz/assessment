class Paper < ActiveRecord::Base
  set_inheritance_column ''

  TYPES = %w[general partial]
  LANGUAGES = %w[Japanese]
  PURPOSES = %w[assess test]
  STATUS = %w[draft public deleted]

  ##----------------------------自定义状态方法---------------------------------
  def draft?
    status == 'draft'
  end

  def public?
    status == 'public'
  end

  def deleted?
    status == 'deleted'
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

  ##----------------------------------------属性----------------------------------------------------------------
  attr_accessible :type, :name, :notice, :score, :duration,
                  :language, :purpose, :has_parts

  ##----------------------------------------关系----------------------------------------------------------------
  belongs_to :general_paper, :class_name => 'Paper', :foreign_key => 'paper_id', :conditions => "type = 'general' and  paper_id is null"
  #只包含未删除的单项
  has_many :partial_papers, :class_name => 'Paper', :conditions => "type = 'partial' and status is null"

  has_many :nodes

  ##----------------------------------------验证----------------------------------------------------------------
  validates :type, :name, :score, :duration, :presence => true
  validates :language, :purpose, :presence => true, :if => "general?"
  validates :name, length: { maximum: 100 }
  validates :score, length: { maximum: 5 }, numericality: { only_integer: true }
  validates :duration, length: { maximum: 5 }, numericality: { only_integer: true }
  validates :score, length: { maximum: 5 },
            numericality: { only_integer: true,
                            :less_than_or_equal_to => Proc.new { |part| part.available_score},
            },
            :if => 'partial?'
  validates :score, length: { maximum: 5 },
            numericality: { only_integer: true,
                            :greater_than_or_equal_to => Proc.new { |paper| paper.already_score},
            },
            :if => 'general?'
  validates :duration, length: { maximum: 5 },
            numericality: { only_integer: true,
                            :less_than_or_equal_to => Proc.new { |part| part.available_duration},
            },
            :if => 'partial?'
  validates :duration, length: { maximum: 5 },
            numericality: { only_integer: true,
                            :greater_than_or_equal_to => Proc.new { |paper| paper.already_duration},
            },
            :if => 'general?'

  ##--------------------------------------查询方法--------------------------------------------------------------
  def already_score
    partial_papers.inject(0) {|score, part| score + part.score}
  end

  def already_duration
    partial_papers.inject(0) {|duration, part| duration + part.duration}
  end
  #此方法应用于part
  def available_score
    if new_record?
      general_paper.score - general_paper.already_score
    else
      p = Paper.find(id)
      general_paper.score - general_paper.already_score + p.score
    end
  end

  def available_duration
    if new_record?
      general_paper.duration - general_paper.already_duration
    else
      p = Paper.find(id)
      general_paper.duration - general_paper.already_duration + p.duration
    end
  end

  #查询出顶级节点，如果是material，将其下问题排序
  def top_nodes
    if partial?
      Node.find_by_sql(["select * from nodes where paper_id = ? and (type='material' or node_id is null)  order by weight asc", id]).map do |node|
        node.questions.order('weight asc') if node.material?
        node
      end
    else
      partial_papers.map {|part| part.questions }.inject(:+)
    end
  end

  # 查询出全部平铺的问题列表
  def questions
    if partial?
      #nodes.where(:depth => 1).order('weight asc').map {|node| node.material? ? node.questions.order('weight asc') : node }.flatten
      Node.find_by_sql(["select * from nodes where paper_id = ? and (type = 'material' or node_id is null) order by weight asc", id]).map {|node| node.material? ? node.questions.order('weight asc') : node }.flatten
    else
      partial_papers.map {|part| part.questions }.inject(:+)
    end
  end
end
