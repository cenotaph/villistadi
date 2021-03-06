# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :aws
  def store_dir
      "/images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  version :twelvehundred do
    process :resize_to_fit => [1200, 900]
  end
  
  version :standard do
    process :resize_to_fit => [800, 600]
  end
  
  
  version :box do
    process :resize_to_fill => [400, 400]
  end
  
  version :thumb do
    process :resize_to_fill => [100, 100]
  end

end
