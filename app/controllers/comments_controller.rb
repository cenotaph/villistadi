class CommentsController < ApplicationController
  before_filter :authenticate_user!
  responders :location, :flash
  respond_to :html
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      respond_with comment.post
    end    
  end
    
  protected
  
  def comment_params
    params.require(:comment).permit([:post_id, :content, :user_id])
  end
  
end