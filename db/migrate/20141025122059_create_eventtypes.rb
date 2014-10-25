class CreateEventtypes < ActiveRecord::Migration
  def self.up
    create_table :eventtypes do |t|
      t.string :colour_code
      t.timestamps
    end
    add_column :events, :eventtype_id, :integer
    Eventtype.create_translation_table! name: :string
  end
  
  def self.down
    drop_table :eventtypes
    Eventtype.drop_translation_table!
    remove_column :events, :eventtype_id
  end
end
