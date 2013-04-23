# -*- encoding : utf-8 -*-
class QuestionsController < ApplicationController
  before_filter :load_test

  add_breadcrumb '考试列表', :tests_path

  # 考题逐题显示
  def index
    #@question = @test.paper.questions.first
    #@solution = @test.question_solution(@question)

    add_breadcrumb '答题', test_questions_path(@test)
  end

  def show
    @question = Node.find(params[:id])

    @question_id = @question.id
  end

  private
  def load_test
    @test = Test.find(params[:test_id])
    render_404 if @test.completed?
  end
end
