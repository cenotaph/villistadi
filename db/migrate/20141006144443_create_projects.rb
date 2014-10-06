class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :city
      t.string :slug
      t.boolean :restricted_membership
      t.boolean :private
      t.integer :maximum_members
      t.boolean :has_forum
      t.boolean :members_can_create_forum_topics
      t.boolean :notify_admin_of_new_member
      t.integer :owner_id, index: true
      t.string :image
      t.integer :image_size, :limit => 8
      t.integer :image_width
      t.integer :image_height
      t.string :image_content_type
      t.timestamps
    end
    Project.create_translation_table! :name => :string, :tagline => :text, :description => :text
  end
  
  def self.down
    drop_table :projects
    Project.drop_translation_table!
  end
end
