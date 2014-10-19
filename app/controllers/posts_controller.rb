class PostsController < ApplicationController
  before_filter :authenticate_user! , :only => [:new, :edit, :update, :create]
  responders :location, :flash
  respond_to :html
  
  def create
    @project = Project.find(params[:project_id])
    @post = Post.new(post_params)
    @project.posts << @post
    @post.published = true  # all project posts are published
    @post.published_at = Time.now
    if @post.save
      respond_with @post, location: -> { @post.project }
    end
  end
  
  def index
    @posts = Post.published.order('published_at DESC')
  end
  
  def new
    # require a project
    @project = Project.find(params[:project_id])
    if can? :create, @project.posts.build
      @post = @project.posts.build
    end
  end
  
  def show
    @post = Post.find(params[:id])
    if @post.project
      render :template => 'projects/post'
    end
  end
  
  protected
  
  def post_params
    params.require(:post).permit([:creator_id, :project_id,  translations_attributes: [:id, :locale, :title, :body]])
  end
end
