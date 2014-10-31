class CommentsController < ApplicationController
  before_filter :authenticate_user!
  responders :location, :flash
  respond_to :html
  
  def create
    @comment = Comment.new(comment_params)
    if params[:project_id]
      @project = Project.find(params[:project_id])
    end
    if params[:forumpost_id]
      @forumpost = Forumpost.find(params[:forumpost_id])
      @comment.commentable = @forumpost
    end
    if @comment.save
      respond_with @comment.commentable
    end    
  end
    
  protected
  
  def comment_params
    params.require(:comment).permit([:post_id, :content, :user_id])
  end
  
end