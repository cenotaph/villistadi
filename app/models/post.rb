class Post < ActiveRecord::Base
  belongs_to :city
  belongs_to :creator, :class_name => 'User'
  translates :title, :body, :fallbacks_for_empty_translations => true
  extend FriendlyId
  friendly_id :title_fi , :use => [ :slugged, :finders]
  before_save :update_icon_attributes
  before_save :check_published
  validates_presence_of :creator_id
  validate :title_present_in_at_least_one_locale #, :image_unless_project
  belongs_to :project
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['title'].blank? && x['body'].blank? }
  mount_uploader :icon, ImageUploader
  has_many :comments, as: :commentable
  
  
  scope :published, -> () {where(published: true)}
  scope :no_project, -> () { where(project_id: nil) }
  scope :by_project, -> (project_id) { where(project_id: project_id) }
  
  def check_published
    if self.published == true
      self.published_at ||= Time.now
    end
  end
  
  def description
    body
  end
  
  def feed_date
    published_at
  end
  def title_fi
    self.title(:fi).blank? ? self.title(:en) : self.title(:fi)
  end

  def image_unless_project
    if icon.blank? && project.blank?
      errors.add(:icon, "You must have an image on a post.")
    end
  end
  
  def name
    title
  end
  
  def title_present_in_at_least_one_locale
    if I18n.available_locales.map { |locale| translation_for(locale).title }.compact.empty?
      errors.add(:base, "You must specify a page title in at least one available language.")
    end
  end  

  def update_icon_attributes
    if icon.present?
      if icon.file.exists?
        self.icon_content_type = icon.file.content_type
        self.icon_size = icon.file.size
        self.icon_width, self.icon_height = `identify -format "%wx%h" #{icon.file.path}`.split(/x/)
      end
    end
  end
  
  def user_id
    creator_id
  end  
    
end
