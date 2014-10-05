class Admin::PlacesController < Admin::BaseController
  responders :location, :flash
  respond_to :html, :json
  has_scope :by_city
  
  def create
    @place = Place.new(place_params)
    if @place.save
      respond_with @place, location: -> { admin_places_path }
    end
    
  end
  
  def destroy
    @place = Place.find(params[:id])
    @place.destroy!
    redirect_to admin_places_path
  end
  
  def index
    @places = apply_scopes(Place).all
    respond_to do |format|
      format.json { 
        render :json => @places.to_json(:only => [:id, :name]), :callback => params[:callback]
      }
      format.html
    end
  end
  
  def update
    @place = Place.find(params[:id])
    if @place.update_attributes(place_params)
      respond_with @place, location: -> { admin_places_path }
    end
  end
  
  private
  
  def place_params
    params.require(:place).permit(:published, :slug, :sw_lat, :sw_lng, :ne_lat, :ne_lng, :city_id, translations_attributes: [:id, :locale, :name, :description])
  end
  
end