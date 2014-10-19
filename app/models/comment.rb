class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates_presence_of :user_id, :post_id
end