class Node < ActiveRecord::Base
  set_inheritance_column ''

  TYPES = %w[material question]
  MEDIA = %w[text audio]
  PATTERNS = %w[single-choice]

  def material?
    type == 'material'
  end

  def question?
    type == 'question'
  end

  # depth废弃
  attr_accessible :type, :media, :content, :depth, :weight,
                  :pattern, :answer, :grade,
                  :node_id, :choices_attributes

  belongs_to :paper

  belongs_to :material, :class_name => 'Node', :conditions => "type = 'material'", :foreign_key => 'node_id'
  has_many :questions, :class_name => 'Node', :conditions => "type = 'question'", :dependent => :nullify

  has_many :choices, :dependent => :destroy

  has_one :answer, :class_name => 'Choice', :foreign_key => 'answer'

  accepts_nested_attributes_for :choices, :allow_destroy => true, :reject_if => proc { |attributes| attributes['content'].blank? }

  after_create :set_answer_from_choices, :if => :question?

  #---------------------------验证-------------------------------------------
  validates :type, :media, :content, :weight, :presence => true
  validates :pattern, :grade, presence: true, if: 'question?'
  validates :grade, length: { maximum: 5 }, numericality: { only_integer: true }, if: 'question?'

   private

  def set_answer_from_choices
     choices.each do |choice|
       answer = choice.id if choice.is_answer?
     end
  end
end
