class Admin::RandombackgroundsController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!

  load_and_authorize_resource 
  skip_before_filter :require_no_authentication
  responders :location, :flash
  respond_to :html, :json

  
  def create
    @randombackground = Randombackground.new(randombackground_params)
    if @randombackground.save
      respond_with @randombackground, location: -> { admin_randombackgrounds_path }
    end
  end
  
  def destroy
    @randombackground = Randombackground.find(params[:id])
    @randombackground.destroy!
    redirect_to admin_randombackgrounds_path
  end
  
  def index
    @randombackgrounds = Randombackground.all
  end

  
  def new
    @randombackground = Randombackground.new
  end
  
  def update
    @randombackground = Randombackground.find(params[:id])
    if @randombackground.update_attributes(randombackground_params)
      respond_with @randombackground, location: -> { admin_randombackgrounds_path }
    end
  end
  
  private
  
  def randombackground_params
    params.require(:randombackground).permit([:active, :background])
  end
  
end