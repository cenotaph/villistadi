class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :update, :edit, :destroy]
  responders :location, :flash
  respond_to :html, :json
  # load_and_authorize_resource through: :user
  
  def create
    @project = Project.new(project_params)
    if @project.save
      respond_with @project
    end
  end
  
  def edit
    @project = Project.find(params[:id])
    if current_user == @project.owner || current_user.has_role?(:goddess)
      render 
    else
      flash[:error] = t(:you_cannot_edit_another_project)
      redirect_to projects_path
    end
  end
  
  def index
    @projects = Project.all
  end
  
  def join
    @project = Project.find(params[:id])
    if @project.users.include?(current_user)
      flash[:notice] = t(:you_are_already_a_member)
    else
      @project.users << current_user
      flash[:notice] = t(:welcome_to_project, :project_name => @project.name)
      redirect_to @project
    end
  end

  def leave
    @project = Project.find(params[:id])
    if @project.users.include?(current_user)
      if current_user.projects_users(:project_id => @project.id).first.is_admin == true
        flash[:error] = t(:you_cannot_leave_when_admin)
      else
        @project.users.delete(current_user)
      end
    else
      flash[:error] = t(:you_are_not_a_member_of_this_project)
    end
    redirect_to @project
  end    

    
  def new
    @project = Project.new
  end
  
  def show
    @project = Project.find(params[:id])
    set_meta_tags :title => t(:project) + " - " + @project.name
  end
  
  def update
    @project = Project.find(params[:id])
    if current_user == @project.owner || current_user.has_role?(:goddess)
      if @project.update_attributes(project_params)
        respond_with @project
      else
        flash[:error] = "Error saving project"
      end
    else
      flash[:error] = t(:you_cannot_edit_another_project)
      redirect_to projects_path
    end
  end    
  
  
  private
  
  def project_params
    params.require(:project).permit(:slug, :city_id, :owner_id, :restricted_membership, :private, :maximum_members, :has_forum, :members_can_create_forum_topics, :notify_admin_of_new_member, :image, translations_attributes: [:id, :locale, :name, :tagline, :description])
  end
  
end