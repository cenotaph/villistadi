class Place < ActiveRecord::Base
  belongs_to :city
  has_many :menus, as: :item
  has_many :photos, as: :imageable
  translates :name, :description, :getting_there, :more_information, :see_and_experience, :future_of, :facts
  extend FriendlyId
  friendly_id :name_fi, :use => [ :slugged, :finders]
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['description'].blank? }
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['image'].blank? }
  validates_presence_of :city_id
  validates_presence_of :ne_lat, :ne_lng, :sw_lat, :sw_lng
  has_many :spots
  mount_uploader :background, PanoramaUploader
  mount_uploader :pdf, AttachmentUploader
  before_save :update_background_attributes
  scope :published, -> () { where(published: true) }
  scope :by_city, -> (x) { where(["city_id is null or city_id = ?", x])}
  validate :name_present_in_at_least_one_locale
  before_save :set_centre
  
  def name_present_in_at_least_one_locale
    if I18n.available_locales.map { |locale| translation_for(locale).name }.compact.empty?
      errors.add(:base, "You must specify a name in at least one language.")
    end
  end  
  
  def name_fi
    self.name(:fi)
  end    

  def center
    [ (ne_lat.to_f + sw_lat.to_f) / 2, (ne_lng.to_f + sw_lng.to_f) / 2]
  end
  
  def set_centre
    self.centre_lat = center.first
    self.centre_lng = center.last
  end
  
  def update_background_attributes
    if background.present?
      if background.file.exists?
        self.background_content_type = background.file.content_type
        self.background_size = background.file.size
        self.background_width, self.background_height = `identify -format "%wx%h" #{background.file.path}`.split(/x/)
      end
    end
  end
  
end
