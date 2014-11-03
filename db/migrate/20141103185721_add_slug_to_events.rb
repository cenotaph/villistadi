class AddSlugToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :slug, :string
    Event.find_each(&:save)
  end
  
  def self.down
    remove_column :events, :slug
  end
end
