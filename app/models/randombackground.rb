class Randombackground < ActiveRecord::Base
  mount_uploader :background, PanoramaUploader
  validates_presence_of :background
  
  scope :active, -> () { where(active: true)}
end
