class AddBackgroundToPlace < ActiveRecord::Migration
  def change
    add_column :places, :background, :string
    add_column :places, :background_width, :integer
    add_column :places, :background_height, :integer
    add_column :places, :background_size, :integer, :limit => 8
    add_column :places, :background_content_type, :string
  end
end
