class PlacesController < ApplicationController
  
  def show
    @place = Place.find(params[:id])
    if !@place.published
      flash[:error] = t(:not_yet_public)
      redirect_to '/'
    end
  end
  
  
end