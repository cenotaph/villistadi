class Admin::PlacesController < Admin::BaseController
  responders :location, :flash
  respond_to :html, :json
  has_scope :by_city
  handles_sortable_columns
  
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
    order = sortable_column_order do |column, direction|
      case column
      when "id"
        "id #{direction}"
      when "name"
        "place_translations.name #{direction}"
      else
        "updated_at DESC"
      end
    end
    @places = apply_scopes(Place).includes(:translations).order(order)
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
    params.require(:place).permit(:published, :slug, :sw_lat, :sw_lng, :ne_lat, :ne_lng, :city_id, :background, :pdf, translations_attributes: [:id, :locale, :name, :description, :getting_there, :see_and_experience, :more_information, :facts, :future_of], photos_attributes: [:id, :locale, :image, :credit, translations_attributes: [:id, :locale, :title]])
  end
  
end