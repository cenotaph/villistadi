class Place < ActiveRecord::Base
  belongs_to :city
  translates :name, :description
  extend FriendlyId
  friendly_id :name_fi, :use => [ :slugged, :finders]
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['description'].blank? }
  validates_presence_of :city_id
  validates_presence_of :ne_lat, :ne_lng, :sw_lat, :sw_lng
  
  scope :published, -> () { where(published: true) }
  scope :by_city, -> (x) { where(["city_id is null or city_id = ?", x])}
  
  def name_fi
    self.name(:fi)
  end    

  def center
    [ (ne_lat.to_f + sw_lat.to_f) / 2, (ne_lng.to_f + sw_lng.to_f) / 2]
  end
end
