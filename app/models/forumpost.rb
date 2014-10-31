class Forumpost < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates_presence_of :project_id, :user_id, :title, :body
  
  def name
    title
  end
  
  def path
    self
  end
end
