class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  belongs_to :city
  has_many :forumposts, :dependent => :destroy
  validates_presence_of :city_id, :owner_id
  translates :name, :description, :tagline, :fallbacks_for_empty_translations => true
  extend FriendlyId
  friendly_id :name_fi, :use => [ :slugged, :finders]
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['description'].blank? && x['tagline'].blank? }
  mount_uploader :image, ImageUploader
  validate :title_present_in_at_least_one_locale
  has_many :projects_users
  has_many :users, through: :projects_users
  #before_save :check_that_owner_is_member
  has_many :posts, dependent: :destroy
  
  def administrators
    [owner, projects_users.where(:is_admin => true).map(&:user)].flatten.uniq.compact
  end
      
  def members
    [owner, projects_users.map(&:user)].flatten.uniq.compact
  end
      
  def check_that_owner_is_member
    owner = User.find(owner_id)
    users << owner unless users.include?(owner)
  end
  
  def latest_forum_activity
    [forumposts, forumposts.map(&:comments).flatten].flatten.sort_by{|x| x.created_at}.last
  end
  
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
  
end
