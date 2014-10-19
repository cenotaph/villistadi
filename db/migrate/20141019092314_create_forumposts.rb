class CreateForumposts < ActiveRecord::Migration
  def change
    create_table :forumposts do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.string :title
      t.text :body
      t.boolean :sticky

      t.timestamps
    end
  end
end
