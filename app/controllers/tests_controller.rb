# -*- encoding : utf-8 -*-
class TestsController < ApplicationController

  before_filter :can_index, :only => [:index]
  before_filter :can_show, :only => [:show]
  before_filter :can_create, :only => [:new, :create, :take]
  before_filter :can_update, :only => [:edit, :update, :destroy]

  add_breadcrumb '考试列表', :tests_path

  def index
    @tests = Test.where(:user_id => current_user.id).order('started_at desc').all
  end

  def new
    @test = Test.new
    @test.paper_id = params[:paper_id]

    add_breadcrumb '开始考试', new_test_path
  end

  def create
    @test = Test.new(params[:test])
    @test.paper_id = params[:paper_id]
    @test.started_at = Time.now
    @test.user = current_user

    if @test.save
      redirect_to test_questions_path(@test)
    else
      render 'new'
    end
  end

  # post交卷 update
  def update
    #@test = Test.find(params[:id])

    @test.ended_at =  Time.now
    @test.score = @test.compute_score.to_s

    if @test.save
      redirect_to @test
    end
  end

  # get结果
  def show
    #@test = Test.find(params[:id])
  end

  def take
    @papers = Paper.where(:type => 'general', :status => 'public')

    add_breadcrumb '参加考试', take_tests_path
  end

  private
  def can_index
    render_404 unless current_user.member?
  end

  def can_show
    @test = Test.find(params[:id])
    render_404 unless current_user.member? && @test.user_id == current_user.id && @test.completed?
  end

  def can_create
    render_404 unless current_user.member?
  end

  def can_update
    @test = Test.find(params[:id])
    render_404 unless current_user.member? && @test.user_id == current_user.id
  end
end
