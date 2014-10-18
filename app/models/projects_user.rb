class ProjectsUser < ActiveRecord::Base
  belongs_to :user, inverse_of: :projects_users
  belongs_to :project, inverse_of: :projects_users
end