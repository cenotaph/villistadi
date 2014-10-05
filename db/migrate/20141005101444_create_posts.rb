class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.references :city, index: true
      t.string :slug
      t.string :icon
      t.integer :icon_width
      t.integer :icon_height
      t.string :icon_content_type
      t.integer :icon_size, :limit => 8
      t.boolean :published
      t.datetime :published_at
      t.integer :creator_id, index: true
      t.timestamps
    end
    Post.create_translation_table! :title => :string, :body => :text
  end
  def self.down
    drop_table :posts
    Post.drop_translation_table!
  end
end
