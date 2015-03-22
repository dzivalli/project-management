# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  def default_url
    ActionController::Base.helpers.asset_path('default.png')
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  process :resize_to_fill => [200, 200], :if => :image?

  # Create different versions of your uploaded files:
  version :thumb, :if => :image? do
    process :resize_to_fill => [88, 88]
  end

  protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

end
