class CreateRandombackgrounds < ActiveRecord::Migration
  def change
    create_table :randombackgrounds do |t|
      t.boolean :active
      t.string :background
      t.integer :background_size, length: 8
      t.integer :background_width
      t.integer :background_height
      t.string :background_content_type

      t.timestamps
    end
  end
end
