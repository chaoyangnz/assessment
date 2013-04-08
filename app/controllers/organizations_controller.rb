# -*- encoding : utf-8 -*-
class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.create_with_admin(params[:organization], params[:admin])

    if @organization.saved?
      redirect_to organizations_path, :notice => '创建机构成功'
    else
      render 'new'
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
       redirect_to  organization_path(@organization), :notice => '更新机构成功'
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

end
