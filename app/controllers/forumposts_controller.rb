class ForumpostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_project, :except => [:create, :update]
    
  def create
    @forumpost = Forumpost.new(forumpost_params)
    if @forumpost.save
      flash[:notice] = t(:post_saved)
      redirect_to @forumpost.project
    end
  end
  
  
  def new
    @forumpost = Forumpost.new(:project => @project)
    set_meta_tags :title => t(:new_forum_post)
  end
  
  def show
    @forumpost = Forumpost.find(params[:id])
    @project = @forumpost.project if @project.nil?
    set_meta_tags :title => @forumpost.project.name + " " + t(:forum) + ": " + @forumpost.title
  end
  
  protected
  
  def forumpost_params
    params.require(:forumpost).permit([:user_id, :project_id, :body, :title])
  end
  
  def get_project
    if params[:project_id]
      @project = Project.find(params[:project_id])
    end
  end
  
end
