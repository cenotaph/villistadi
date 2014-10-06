class CreateProjectUsers < ActiveRecord::Migration
  def change
    create_table :projects_users , :id => false do |t|
      t.references :project, index: true, null: false
      t.references :user, index: true, null: false
    end
    add_index :projects_users, [ :project_id, :user_id ], :unique => true, :name => 'by_project_and_user'
  end
end
