class Choice < ActiveRecord::Base
  attr_accessible :content, :weight, :is_answer

  belongs_to :question, :class_name => 'Node', :foreign_key => 'node_id', :conditions => "type = 'question'"
end
