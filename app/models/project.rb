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
  
  scope :archived, -> () { where(archived: true) }
  scope :active, -> () { where(archived: false)}
  
  def administrators
    [owner, projects_users.where(:is_admin => true).map(&:user)].flatten.uniq.compact
  end
      
  def approved_members
    projects_users.where("pending is not true").where(denied: false).map(&:user)
  end
  
  def denied_members
    projects_users.where("pending is not true").where(denied: true).map(&:user)
  end

  def members
    [owner, projects_users.where("pending is not true").where(denied: false).map(&:user)].flatten.uniq.compact
  end
  
  def unapproved_members
    projects_users.where(pending: true).map(&:user)
  end
      
  def check_that_owner_is_member
    owner = User.find(owner_id)
    users << owner unless users.include?(owner)
  end
  
  def last_activity_sort
    out = []
    unless forumposts.empty?
      out << [forumposts, forumposts.map(&:comments).flatten].flatten.sort_by{|x| x.created_at}.last.created_at
    end
    unless posts.empty?
      out << posts.sort_by{|x| x.published_at}.last.published_at
    end
    out << updated_at
    out
  end
  
  def latest_forum_activity
    [forumposts, forumposts.map(&:comments).flatten].flatten.sort_by{|x| x.created_at}.last
  end
  
  def name_fi
    self.name(:fi).blank? ? self.name(:en) : self.name(:fi)
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
