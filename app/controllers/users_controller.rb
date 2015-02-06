class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def approve
    @project = Project.find(params[:project_id])
    if can? :manage, @project
      @user = User.find(params[:id])
      pu = ProjectsUser.find_by(user: @user, project: @project)
      pu.pending = false
      pu.denied = false
      pu.save!
    else
      flash[:error] = 'Error finding project or user'
    end
    redirect_to @project
  end

  def deny
    @project = Project.find(params[:project_id])
    if can? :manage, @project
      @user = User.find(params[:id])
      pu = ProjectsUser.find_by(user: @user, project: @project)
      pu.pending = false
      pu.denied = true
      pu.save!
    else
      flash[:error] = 'Error finding project or user'
    end
    redirect_to @project
  end
    
  def show
    @user = User.find(params[:id])
  end
  
end
