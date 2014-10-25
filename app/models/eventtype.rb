class Eventtype < ActiveRecord::Base
  translates :name, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, reject_if: proc{|x| x['name'].blank? }
  validates_presence_of :colour_code
end
