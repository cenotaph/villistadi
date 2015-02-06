class AddPendingToProjectsUsers < ActiveRecord::Migration
  def change
    add_column :projects_users, :pending, :boolean
  end
end
