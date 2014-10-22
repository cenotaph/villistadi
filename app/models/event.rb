class Event < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates_presence_of :start_at, :venue, :contact_name, :contact_contact, :title, :user_id, :address1
  has_event_calendar
  
  scope :approved, -> () { where(approved: true)}
  scope :in_future, where(["start_at >= ?", Time.zone.now])
  
  def happens_on?(day)
    return true if day.to_date >= start_at.to_date && day.to_date <= end_at.to_date
  end
  
  def name
    title
  end

  def sort_date
    end_at.blank? ? start_at : end_at
  end
  
end
