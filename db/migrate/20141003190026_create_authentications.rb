class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :username

      t.timestamps
    end
    add_index :authentications, [:user_id, :provider, :uid], unique: true
  end
end
