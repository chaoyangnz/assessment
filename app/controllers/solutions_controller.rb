# -*- encoding : utf-8 -*-
class SolutionsController < ApplicationController
  before_filter :load_test_and_question

  # 选择答案
  def update
    @solution = @test.question_solution(@question)

    @orginal = @question
    @question_id = params[:next_id]
    if @solution.update_attributes(params[:solution])
      render 'questions/show', :layout => false
    end
  end

  def mark
    solution = @test.question_solution(@question)
  end

  private
  def load_test_and_question
    @test = Test.find(params[:test_id])
    @question = Node.find(params[:question_id])
  end
end
