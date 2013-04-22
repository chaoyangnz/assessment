# -*- encoding : utf-8 -*-
class PartsController < ApplicationController
  before_filter :can_index, :only => [:index]
  before_filter :can_show, :only => [:show]
  before_filter :can_create, :only => [:new, :create]
  before_filter :can_update, :only => [:edit, :update, :destroy]

  #before_filter :load_paper
  add_breadcrumb '试卷列表', :papers_path

  def index
    @parts = @paper.partial_papers

    add_breadcrumb '单项设置', :paper_parts_path
  end

  def new
    @part = Paper.new
    @part.type = 'partial'
  end

  def create
    @part = Paper.new(params[:paper])
    @part.type = 'partial'
    @part.has_parts = false
    @part.general_paper = @paper

    if @part.save
      redirect_to paper_parts_path
    else
      render 'new'
    end
  end

  def edit
    #@part = Paper.find(params[:id])
  end

  def update
    #@part = Paper.find(params[:id])

    if @part.update_attributes(params[:paper])
      redirect_to paper_parts_path(@paper), :notice => '更新单项试卷成功'
    else
      render 'edit'
    end
  end

  def destroy
    #@part = Paper.find(params[:id])

    if @part.update_attribute(:status, :deleted)
      redirect_to paper_parts_path(@paper), :notice => '删除成功'
    else
      render 'index'
    end

  end

  private
  #def load_paper
  #  @paper = Paper.find(params[:paper_id])
  #  render_404 unless @paper.has_parts?
  #end

  def can_index
    @paper = Paper.find(params[:paper_id])
    render_404 and return unless current_user.root?
  end

  def can_create
    @paper = Paper.find(params[:paper_id])
    render_404 and return unless current_user.root?

    render_404 and return unless @paper.draft?
  end

  def can_show
    @paper = Paper.find(params[:paper_id])
    @part = Paper.find(params[:id])
    render_404 and return unless current_user.root? && @part.partial? && @part.paper_id == @paper.id
  end

  def can_update
    @paper = Paper.find(params[:paper_id])
    @part = Paper.find(params[:id])
    render_404 and return unless current_user.root? && @part.partial? && @part.paper_id == @paper.id

    render_404 and return unless @paper.draft?
    render_404 and return if @part.deleted?
  end
end
