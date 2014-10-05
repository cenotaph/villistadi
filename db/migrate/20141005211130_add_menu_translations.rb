class AddMenuTranslations < ActiveRecord::Migration
  def self.up
    Menu.create_translation_table! :display_name => :string
  end
  
  def self.down
    Menu.drop_translation_table!
  end
end
