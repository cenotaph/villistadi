class AddPublishedToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :published, :boolean
  end
end
