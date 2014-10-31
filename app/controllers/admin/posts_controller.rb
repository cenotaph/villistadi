class Admin::PostsController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
  #load_and_authorize_resource
  # check_authorization
  load_and_authorize_resource 
  skip_before_filter :require_no_authentication
  responders :location, :flash
  respond_to :html, :json
  has_scope :by_city
  
  def create
    @post = Post.new(post_params)
    if @post.save
      respond_with @post, location: -> { admin_posts_path }
    end
    
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to admin_posts_path
  end
  
  def index
    @posts = apply_scopes(Post).all
    respond_to do |format|
      format.json { 
        render :json => @posts.to_json(:only => [:id, :name]), :callback => params[:callback]
      }
      format.html
    end
  end
  
  def new
    @post = Post.new(:creator_id => current_user.id)
    set_meta_tags :title => 'Admin: new post'
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      respond_with @post, location: -> { admin_posts_path }
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:published, :slug, :icon, :published_at, :creator_id,  :city_id, translations_attributes: [:id, :locale, :title, :body])
  end
  
end