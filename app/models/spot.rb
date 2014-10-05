class Spot < ActiveRecord::Base
  belongs_to :place
  translates :name, :description, :fallbacks_for_empty_translations => true
  belongs_to :creator, :class_name => 'User'
  extend FriendlyId
  friendly_id :name_fi , :use => [ :slugged, :finders]
  before_save :update_image_attributes
  validate :title_present_in_at_least_one_locale
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['description'].blank? }
  mount_uploader :icon, ImageUploader
  validates_presence_of :place_id, :latitude, :longitude
  
  scope :published, -> () {where(published: true)}
  scope :by_place, -> (x) { where(place_id: x) }
  
  def name_fi
    self.name(:fi)
  end

  def title_present_in_at_least_one_locale
    if I18n.available_locales.map { |locale| translation_for(locale).name }.compact.empty?
      errors.add(:base, "You must specify a name in at least one language.")
    end
  end  

  def update_image_attributes
    if image.present?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end
  
  def user_id
    creator_id
  end  
    
end
