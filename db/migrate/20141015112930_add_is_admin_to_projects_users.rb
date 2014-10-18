class AddIsAdminToProjectsUsers < ActiveRecord::Migration
  def change
    add_column :projects_users, :is_admin, :boolean
    add_column :projects_users, :receive_emails, :boolean
    add_column :posts, :project_id, :integer, :default => nil
  end
end
