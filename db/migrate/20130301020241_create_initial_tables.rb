class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table(:organizations) do |t|
      t.string :name,              :null => false, :default => ""
      t.string :address
      t.string :telephone
      t.string :linkman

      t.timestamps
    end

    ## 题库相关
    create_table :papers do |t|
      ## 试卷类型：综合、单项
      t.string :type,          :null => false, :default => 'general'
      t.string :name,          :null => false
      t.string :notice
      t.integer :score
      t.integer :duration
      t.string :created_by


      ## --------general paper only -------------
      t.boolean :has_parts
      t.string :language
      # 试卷用途：1. 自我测评、模拟题  2. 真实考试
      t.string :purpose
      t.string :status
      #------------------------------------------

      t.belongs_to :paper

      t.timestamps
    end

    # 题干
    create_table :nodes do |t|
      # 题干类型：材料、问题
      t.string :type, :null => false, :default => 'question'
      ## 文本参照 ， 音频参照
      t.string :media,  :null => false, :default => 'text'
      t.string :content, :null => false
      t.integer :depth
      t.integer :weight

      ## ---------question only--------------
      ## 单选、多选、填空、论文
      t.string :pattern
      t.string :answer
      t.integer :grade
      #------------------------------------------

      t.belongs_to :paper, :null => false
      t.belongs_to :node
    end

    create_table :choices do |t|
      t.string :content, :null => false
      t.string :weight
      t.boolean :is_answer

      t.belongs_to :node, :null => false
    end

    ## 考试过程
    create_table :tests do |t|
      #t.string :mode,       :null => false
      t.string :score
      t.string :status
      t.timestamp :started_at
      t.timestamp :ended_at
      t.string :finish_reason

      t.belongs_to :user
      t.belongs_to :paper
    end

    # 答题卡
    create_table :solutions do |t|
      t.boolean :has_mark
      t.string :answer

      t.belongs_to :test
      t.belongs_to :node

      t.timestamps
    end

    add_index :organizations, :name,                :unique => true
  end
end
