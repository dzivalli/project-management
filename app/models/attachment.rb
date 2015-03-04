class Attachment < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  # has_one :owner, class_name: 'User', foreign_key: avatar_id

  mount_uploader :file, FileUploader
end
