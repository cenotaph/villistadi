class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :update, :edit, :destroy]
  # responders :location, :flash
  respond_to :html, :json
  # load_and_authorize_resource through: :user
  
  def create
    @project = Project.new(project_params)
    @project.projects_users << ProjectsUser.new(:user => current_user, :is_admin => true)
    if @project.save
      respond_with @project
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    if can? :destroy, @project
      @project.destroy!
      flash[:notice] = t(:your_project_has_been_deleted)
    end
    redirect_to projects_path
  end
  
  def edit
    @project = Project.find(params[:id])
    if @project.projects_users.map(&:user).include?(current_user) || current_user.has_role?(:goddess)
      set_meta_tags :title => t(:project) + " - " + @project.name
      render 
    else
      flash[:error] = t(:you_cannot_edit_another_project)
      redirect_to projects_path
    end
  end
  
  def index
    @active = Project.active
    @archived = Project.archived
    
    
    set_meta_tags :title => t(:projects),
    canonical: url_for(@projects),
    og: { title: t(:projects), 
          url: url_for(@projects), 
          image:'http://villistadi.fi/assets/vs_black_small.png'
        }
  end
  
  def join
    @project = Project.find(params[:id])
    if @project.members.include?(current_user)
      flash[:notice] = t(:you_are_already_a_member)
    else
      if @project.private == true
        flash[:notice] = t(:your_request_must_be_approved)
        begin
          if ProjectsUser.create(project: @project, user: current_user, pending: true)
            ProjectMailer.request_to_join(current_user, @project).deliver_now
          end
        rescue
          ProjectMailer.request_to_join(current_user, @project).deliver_now
        end
        redirect_to projects_path
      else
        @project.users << current_user
        flash[:notice] = t(:welcome_to_project, :project_name => @project.name)
        redirect_to @project
      end
    end
  end

  def leave
    @project = Project.find(params[:id])
    if @project.users.include?(current_user)
      if @project.administrators.include?(current_user) && @project.administrators.size == 1
        flash[:error] = t(:you_cannot_leave_when_admin)
      else
        if @project.administrators.include?(current_user) && @project.owner == current_user
          # change the owner to the next admin in the list
          @project.owner = @project.administrators.to_a.delete_if{|x| x == current_user}.first
          @project.save!
        end
        @project.users.delete(current_user)
      end
    else
      flash[:error] = t(:you_are_not_a_member_of_this_project)
    end
    redirect_to @project
  end    

    
  def new
    @project = Project.new
    set_meta_tags :title => t(:create_new_project)
  end
  
  def show
    @project = Project.find(params[:id])
    if @project.private == true
      if !can? :read, @project
        flash[:error] = t(:private_project)
        redirect_to projects_path
      end
    end
    
    if @project.description(:en) != @project.description(:fi)
      a = Hash.new
      a["en"] = url_for(@project) + "?locale=en"
      a["fi"] = url_for(@project) + "?locale=fi"
    else
      a = {}
    end

    
    set_meta_tags :title => t(:project) + " - " + @project.name.html_safe, 
      canonical: url_for(@project),
      og: { title:t(:project) + " - " + @project.name.html_safe, 
            url: url_for(@project), 
            image: (@project.image? ? [ @project.image.url(:box).gsub(/^https/, 'http'),
                           { secure_url: @project.image.url(:box) } ] : 
                       'http://villistadi.fi/assets/vs_black_small.png') 
          },
      alternate: a

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
    params.require(:project).permit(:slug, :archived, :city_id, :owner_id, :restricted_membership, :private, :maximum_members, :has_forum, :members_can_create_forum_topics, :notify_admin_of_new_member, :image, translations_attributes: [:id, :locale, :name, :tagline, :description])
  end
  
end