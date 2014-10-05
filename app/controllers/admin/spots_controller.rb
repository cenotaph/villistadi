class Admin::SpotsController < Admin::BaseController
  responders :location, :flash
  respond_to :html, :json
  has_scope :by_place
  
  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      respond_with @spot, location: -> { admin_spots_path }
    end
    
  end
  
  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy!
    redirect_to admin_spots_path
  end
  
  def index
    @spots = apply_scopes(Spot).all
    respond_to do |format|
      format.json { 
        render :json => @spots.to_json(:only => [:id, :name]), :callback => params[:callback]
      }
      format.html
    end
  end
  
  def update
    @spot = Spot.find(params[:id])
    if @spot.update_attributes(spot_params)
      respond_with @spot, location: -> { admin_spots_path }
    end
  end
  
  private
  
  def spot_params
    params.require(:spot).permit(:published, :slug, :latitude, :longitude, :place_id, translations_attributes: [:id, :locale, :name, :description])
  end
  
end