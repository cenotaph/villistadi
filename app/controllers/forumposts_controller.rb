class ForumpostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
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
    if @project['private'] == true
      if !user_signed_in?
        flash[:error] = t(:you_must_be_a_member_of_this_project)
        redirect_to @project
      else
        if !@project.members.include?(current_user) && !current_user.has_role?(:goddess)
          flash[:error] = t(:you_must_be_a_member_of_this_project)
          redirect_to @project
        end
      end
    end
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
