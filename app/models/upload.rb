class Upload < ActiveRecord::Base
  set_inheritance_column ''
  include Rails.application.routes.url_helpers

  attr_accessible :file, :type, :original_name

  mount_uploader :file, UploadUploader

end
