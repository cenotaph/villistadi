# encoding: utf-8

class PanoramaUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  
  def store_dir
      "/backgrounds/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  version :full do
    process :resize_to_fit => [1920, 1080]
  end
  
  version :box do
    process :resize_to_fill => [400, 400]
  end
  
  version :thumb do
    process :resize_to_fill => [100, 100]
  end

end
