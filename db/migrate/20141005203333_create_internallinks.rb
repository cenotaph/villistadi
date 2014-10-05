class CreateInternallinks < ActiveRecord::Migration
  def self.up
    create_table :internallinks do |t|
      t.string :controller
      t.string :action
      t.string :parameter
      t.string :name
      t.boolean :published
      t.string :custom_url
      t.timestamps
    end
    Internallink.create_translation_table! :display_name => :string
  end
  
  def self.down
    drop_table :internallinks
    Internallink.drop_translation_table!
  end
  
end
