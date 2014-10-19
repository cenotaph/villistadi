class PlacesController < ApplicationController
  
  def show
    @place = Place.find(params[:id])
    if !@place.published
      flash[:error] = t(:not_yet_public)
      redirect_to '/'
    end
    if @place.background?
      @background_css = "background: url(#{@place.background.url(:full)}) no-repeat center center; background-size: cover"
    end
  end
  
  
end