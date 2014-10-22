class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.string :title
      t.string :address1
      t.string :city
      t.string :postcode
      t.string :venue
      t.datetime :start_at
      t.datetime :end_at
      t.text :description
      t.string :contact_name
      t.string :contact_contact
      t.boolean :approved, :null => false, default: false

      t.timestamps
    end
  end
end
