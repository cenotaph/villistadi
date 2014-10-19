class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  mount_uploader :image, ImageUploader
  before_save :update_image_attributes
  translates :title
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['title'].blank? }
  
  def update_image_attributes
    if image.present?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end

end
