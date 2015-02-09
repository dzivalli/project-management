class Attachment < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  mount_uploader :file, FileUploader
end
