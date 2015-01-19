class Event < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :eventtype
  validates_presence_of :start_at, :venue, :contact_name, :contact_contact, :title, :user_id, :address1
  has_event_calendar
  geocoded_by :full_address
  after_validation :geocode, :on => :create
  scope :approved, -> () { where(approved: true)}
  scope :unapproved, -> () {where(approved: false)}
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :finders]
  
  scope :in_future, ->() { where(["start_at >= ?", Time.zone.now]) }
  
  def color 
    eventtype.nil? ?  "#82879B" : "#" + eventtype.try(:colour_code)
  end
  
  def full_address
    [address1 , address2, city, postcode, 'Finland'].delete_if {|x| x.blank? }.compact.join(', ')
  end
  
  def end_at
    self[:end_at].nil? ? start_at : self[:end_at]
  end
  
  def happens_on?(day)
    return true if day.to_date >= start_at.to_date && day.to_date <= end_at.to_date
  end
  
  def name
    title
  end
  
  def feed_date
    created_at
  end
  
  def body
    description
  end

  def sort_date
    end_at.blank? ? start_at : end_at
  end
  
end
