class Page < ActiveRecord::Base
  acts_as_tree 
  belongs_to :city
  has_many :menus, as: :item
  translates :name, :body, :fallbacks_for_empty_translations => true
  extend FriendlyId
  friendly_id :name_fi, :use => [ :slugged, :finders]
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['body'].blank? }
  scope :published, -> () { where(published: true) }
  scope :by_city, -> (x) { where(["city_id is null or city_id = ?", x])}
  
  def name_fi
    self.name(:fi).blank? ? self.name(:en) : self.name(:fi)
  end
  
  def title
    name
  end
  
  
end
