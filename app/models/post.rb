class Post < ActiveRecord::Base
  belongs_to :city
  belongs_to :creator, :class_name => 'User'
  translates :title, :body, :fallbacks_for_empty_translations => true
  extend FriendlyId
  friendly_id :title_fi , :use => [ :slugged, :finders]
  before_save :update_image_attributes
  before_save :check_published
  validate :title_present_in_at_least_one_locale
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['title'].blank? && x['body'].blank? }
  mount_uploader :icon, ImageUploader
  
  def check_published
    if self.published == true
      self.published_at ||= Time.now
      unless self.new_record? || hide_from_feed != false
        add_to_feed('created')
      end
    else
      unless feeds.empty?
        feeds.map(&:destroy)
      end
    end
    if self.creator_id.blank?
      self.creator_id = self.last_modified_id
    end
  end
  
  def description
    body
  end
  
  def title_fi
    self.title(:fi)
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