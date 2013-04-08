# -*- encoding : utf-8 -*-
class PapersController < ApplicationController
  add_breadcrumb '试卷列表', :papers_path

  def index
    @papers = Paper.where(:type => 'general')
  end

  def new
    @paper = Paper.new
    @paper.type = 'general'
    @paper.status = 'draft'

    add_breadcrumb '新增试卷', new_paper_path

  end

  def create
    @paper = Paper.new(params[:paper])
    @paper.status = 'draft'
    if @paper.save
      if @paper.has_parts?
        redirect_to paper_parts_path(@paper), :notice => '试卷创建成功'
      else
        redirect_to edit_paper_path(@paper), :notice => '试卷创建成功'
      end
    else
      render 'new'
    end
  end

  def show
    @paper = Paper.find(params[:id])
    render_404 if @paper.partial?

    add_breadcrumb '试卷信息', paper_path(@paper)
  end

  def edit
    @paper = Paper.find(params[:id])
    render_404 if @paper.partial?

    add_breadcrumb '编辑试卷', paper_path(@paper)
  end

  def update
    @paper = Paper.find(params[:id])

    if @paper.update_attributes(params[:paper])
      redirect_to papers_path, :notice => '更新试卷成功'
    else
      render 'edit'
    end
  end

  def publish
    @paper = Paper.find(params[:id])
    if @paper.update_attribute(:status, 'public')
      redirect_to papers_path, :notice => '发布试卷成功'
    end

  end
end
