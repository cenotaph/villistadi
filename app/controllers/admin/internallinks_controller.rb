class Admin::InternallinksController < ApplicationController
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
    @internallink = Internallink.new(internallink_params)
    if @internallink.save
      respond_with @internallink, location: -> { admin_internallinks_path }
    end
    
  end
  
  def destroy
    @internallink = Internallink.find(params[:id])
    @internallink.destroy!
    redirect_to admin_internallinks_path
  end
  
  def index
    @internallinks = apply_scopes(Internallink).all
    respond_to do |format|
      format.json { 
        render :json => @internallinks.to_json(:only => [:id, :name]), :callback => params[:callback]
      }
      format.html
    end
  end
  
  def new
    @internallink = Internallink.new
  end
  
  def update
    @internallink = Internallink.find(params[:id])
    if @internallink.update_attributes(internallink_params)
      respond_with @internallink, location: -> { admin_internallinks_path }
    end
  end
  
  private
  
  def internallink_params
    params.require(:internallink).permit(:published, :controller, :action, :parameter, :name, :custom_url, translations_attributes: [:id, :locale, :display_name])
  end
  
end