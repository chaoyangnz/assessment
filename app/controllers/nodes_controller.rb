# -*- encoding : utf-8 -*-
class NodesController < ApplicationController
  before_filter :load_paper

  def index
    #@nodes = Node.order('weight asc').where(:depth => 1, :paper_id => @paper.id).map do |node|
    @nodes = Node.find_by_sql(["select * from nodes where (type='material' or node_id is null) and paper_id = ? order by weight asc", @paper.id]).map do |node|
      node.questions.sort!() if node.material?
      node
    end
  end

  def new
    @node = Node.new
    @node.paper = @paper
    @node.type = params[:type] || 'question'

    if @node.material?
      render 'new_material'
    else
      @materials = Node.where(:type => 'material', :paper_id => @paper.id).map {|material| [material.content, material.id]}
      render 'new_question'
    end
  end

  def create
    @node = Node.new(params[:node])
    @node.paper = @paper
    #@node.depth = @node.material? || @node.node_id.blank? ? 1 : 2

    if @node.save
      redirect_to paper_nodes_path(@paper), :notice => "#{t('dict.'+@node.type)}创建成功"
    else
      if @node.material?
        render 'new_material'
      else
        @materials = Node.where(:type => 'material', :paper_id => @paper.id).map {|material| [material.content, material.id]}
        render 'new_question'
      end
    end
  end

  def edit
    @node = Node.find(params[:id])

    if @node.material?
      render 'edit_material'
    else
      @materials = Node.where(:type => 'material', :paper_id => @paper.id).map {|material| [material.content, material.id]}
      render 'edit_question'
    end
  end

  def update
    @node = Node.find(params[:id])
    @node.assign_attributes(params[:node])
    #@node.depth = @node.material? || @node.node_id.blank? ? 1 : 2

    if @node.save
      redirect_to paper_nodes_path(@paper)
    else
      render 'edit'
    end
  end

  def destroy
    @node = Node.find(params[:id])

    if  @node.destroy
      redirect_to paper_nodes_path(@paper), :notice => '删除成功'
    else
      render 'index'
    end

  end

  private
  def load_paper
    @paper = Paper.find(params[:paper_id])
    # 只允许单项以及没有任何单项的综合试卷允许编辑考试题
    render_404 if @paper.general? && @paper.has_parts?
  end
end
