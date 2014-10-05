class CreateSpots < ActiveRecord::Migration
  def self.up
    create_table :spots do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :slug
      t.string :image
      t.integer :image_size, :limit => 8
      t.integer :image_width
      t.integer :image_height
      t.string :image_content_type
      t.integer :creator_id, index: true
      t.references :place, index: true
      t.timestamps
    end
    Spot.create_translation_table! :name => :string, :description => :text
  end
  
  def self.down
    drop_table :spots
    Spot.drop_translation_table!
  end
  
end
