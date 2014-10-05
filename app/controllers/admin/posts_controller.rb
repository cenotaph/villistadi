class Admin::PostsController < Admin::BaseController
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
    @post = Post.new
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