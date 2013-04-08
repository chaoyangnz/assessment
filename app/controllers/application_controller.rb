# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'application'
  respond_to :html, :js

  before_filter :authenticate_user!

  add_breadcrumb '首页', "/"

  protected
  # patch helper for AJAX redirect
  def redirect_to(options = {}, response_status = {})
    super(options, response_status)
    if request.xhr?
      # empty to prevent render duplication exception
      path = self.location

      self.status = 200
      self.response_body = nil
      #self.location = nil

      logger.info 'When XHR, use browser js for redirect!'

      render :js => "window.location = #{path.to_json}"
    end
  end

  def render_404
    respond_to do |format|
      format.html { render :file => Rails.root.join("public", "404"), :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  # around filter for transaction
  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      begin
        yield
      ensure
        raise ActiveRecord::Rollback
      end
    end
  end
end
