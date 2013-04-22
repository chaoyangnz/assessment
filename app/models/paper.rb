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
    status = 'deleted'
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
  has_many :partial_papers, :class_name => 'Paper', :conditions => "type = 'partial' and status is null"

  has_many :nodes

  ##----------------------------------------验证----------------------------------------------------------------
  validates :type, :name, :score, :duration, :presence => true
  validates :language, :purpose, :presence => true, :if => "general?"
  validates :name, length: { maximum: 100 }
  validates :score, length: { maximum: 5 }, numericality: { only_integer: true }
  validates :duration, length: { maximum: 5 }, numericality: { only_integer: true }

  ##--------------------------------------查询方法--------------------------------------------------------------
  def questions
    if partial?
      nodes.where(:depth => 1).order('weight asc').map {|node| node.material? ? node.questions.order('weight asc') : node }.flatten
    else
      partial_papers.map {|part| part.questions }.inject(:+)
    end
  end
end
