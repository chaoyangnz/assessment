# -*- encoding : utf-8 -*-
class PartsController < ApplicationController
  before_filter :load_paper
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
    @part = Paper.find(params[:id])
  end

  def update
    @part = Paper.find(params[:id])
    if @part.update_attributes(params[:paper])
      redirect_to paper_parts_path(@paper), :notice => '更新单项试卷成功'
    else
      render 'edit'
    end
  end

  def destroy
    @part = Paper.find(params[:id])

    if @part.update_attribute(:status, :deleted)
      redirect_to paper_parts_path(@paper), :notice => '删除成功'
    else
      render paper_parts_path(@paper)
    end

  end

  private
  def load_paper
    @paper = Paper.find(params[:paper_id])
    render_404 unless @paper.has_parts?
  end
end
