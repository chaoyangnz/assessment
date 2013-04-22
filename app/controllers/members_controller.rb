# -*- encoding : utf-8 -*-
class MembersController < ApplicationController

  before_filter :can_resources, :only => [:index, :new, :create]
  before_filter :can_resource, :only => [:show, :edit, :update, :destroy]

  add_breadcrumb '人员列表', :members_path

  def index
    @members = current_user.organization.members
  end

  def new
    add_breadcrumb '新增人员', :new_member_path
  end

  def create
    @member = User.invite!(:email => params[:email]) do |u|
      u.skip_invitation = true
      u.role = 'member'
      u.organization_id = current_user.organization.id
    end

    if @member.invited_to_sign_up?
      redirect_to members_path, :notice => '已经发送注册邀请码'
    else
      render 'new'
    end
  end

  def show
    @tests = Test.where(:user_id => params[:id]).order('started_at desc').all

    add_breadcrumb '考试历史', member_path(@member)
  end

  def destroy
    if @member.update_attribute(:status, :deleted)
      redirect_to members_path
    else
      render 'index'
    end
  end

  private
  def can_resources
    render_404 unless current_user.admin?
  end

  def can_resource
    @member = User.find(params[:id])
    render_404 unless current_user.admin? && @member.organization_id == current_user.organization_id && @member.member?
  end
end
