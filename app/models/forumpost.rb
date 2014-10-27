class Forumpost < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :comments, as: :commentable
  validates_presence_of :project_id, :user_id, :title, :body
  
end
