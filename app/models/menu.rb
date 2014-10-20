class Menu < ActiveRecord::Base
  acts_as_tree
  belongs_to :city
  validates_presence_of :city_id, :item_type
  belongs_to :item, polymorphic: true
  before_save :check_sort_order
  translates :display_name, :fallbacks_for_empty_translations => true
  scope :published, -> { where(published: true)}
  scope :by_city, ->(x) { where(city_id: x)}
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['display_name'].blank? }
  def check_sort_order
    self.sort_order = (sort_order.nil? ? 1 : sort_order)
  end
  
  def item_name
    if item
      if item.respond_to?('display_name')
        item.display_name
      else
        item.name
      end
    else
      display_name
    end
  end
  
  def link
    if item_type == 'Page'
      "/pages/" + item.slug
    elsif item_type == 'Place'
      "/places/" + item.slug
    elsif item_type == 'nothing'
      '#'
    elsif item_type == 'Internallink'
      if item.custom_url.blank?
        "/" + [item.controller, item.action, item.parameter].delete_if{|x| x.blank?}.compact.join("/")
      else
        item.custom_url
      end
    end
  end
end  

