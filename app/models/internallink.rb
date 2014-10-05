class Internallink < ActiveRecord::Base
  translates :display_name
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['display_name'].blank? }
  scope :by_city, -> (x) {where("id is not null")}
end
