class Solution < ActiveRecord::Base
  attr_accessible :answer, :has_mark

  belongs_to :test
  belongs_to :question, :class_name => 'Node', :foreign_key => 'node_id'

  def has_answer?
    ! answer.blank?
  end
end
