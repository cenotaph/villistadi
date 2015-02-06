class AddDeniedToProjectsUsers < ActiveRecord::Migration
  def change
    add_column :projects_users, :denied, :boolean, null: false, default: false
  end
end
