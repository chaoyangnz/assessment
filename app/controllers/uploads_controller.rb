class UploadsController < ApplicationController

  def index
    @uploads = Upload.all.order('created_at desc')

    respond_to do |format|
      format.html # take.html.erb
      format.js{ render :layout => false}
    end
  end

  def create
    file = params[:Filedata].is_a?(ActionDispatch::Http::UploadedFile) ? params[:Filedata] : params[:file]
    @upload = Upload.new
    @upload.file = file
    @upload.type = params[:type]
    @upload.original_name = params[:Filename]
    if @upload.save
      render json: @upload.to_json
    else
      render json: @upload.errors.to_json
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_path }
      format.js{ 
        @uploads = Upload.all.desc(:created_at)
        render :layout => false
      }
    end

  end

end
