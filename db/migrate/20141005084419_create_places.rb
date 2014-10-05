class CreatePlaces < ActiveRecord::Migration
  
  def self.up
    create_table :places do |t|
      t.references :city, index: true
      t.decimal :sw_lat, :precision => 10, :scale => 8
      t.decimal :sw_lng, :precision => 10, :scale => 8
      t.decimal :ne_lat, :precision => 10, :scale => 8
      t.decimal :ne_lng, :precision => 10, :scale => 8
      t.string :slug
      t.boolean :published
      t.timestamps
    end
    Place.create_translation_table!  :name => :string, :description => :text
  end
  
  def self.down
    drop_table :places
    Place.drop_translation_table!
  end
  
end
