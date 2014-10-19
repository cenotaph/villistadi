class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :image
      t.integer :image_width
      t.integer :image_height
      t.string :image_content_type
      t.integer :image_size, length: 8
      t.references :imageable, polymorphic: true, index: true
      t.string :credit
      t.timestamps
    end
    Photo.create_translation_table! title: :string
  end
  
  def self.down
    drop_table :photos
    Photo.drop_translation_table!
  end
  
end
