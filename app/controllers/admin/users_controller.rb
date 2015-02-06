class Admin::UsersController < Admin::BaseController
  responders :location, :flash
  respond_to :html, :json, :csv
  has_scope :by_place
  handles_sortable_columns
  
  def create
    @user = User.new(user_params)
    if @user.save
      respond_with @user, location: -> { admin_users_path }
    end
    
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to admin_users_path
  end
  
  def index
    order = sortable_column_order
    @users = apply_scopes(User).all.order(order)   
    respond_to do |format|
      format.json { 
        render :json => @users.to_json(:only => [:id, :name]), :callback => params[:callback]
      }
      format.html
      format.csv
    end
    set_meta_tags title: 'Users'
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      respond_with @user, location: -> { admin_users_path }
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :username, :email, role_ids: [] )
  end
  
end