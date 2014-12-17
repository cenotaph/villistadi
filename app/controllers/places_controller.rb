class PlacesController < ApplicationController
  
  def index
    @places = Place.published
    set_meta_tags :title => t(:places)
    render :layout => 'bigmap'
  end
  
  def show
    @place = Place.find(params[:id])
    if !@place.published 
      if !can? :view, @place
        flash[:error] = t(:not_yet_public)
        redirect_to '/'
      end
    end
    if @place.background?
      @background_css = "background: url(#{@place.background.url(:full)}) no-repeat top center fixed; background-size: cover"
    else
      @background_css = 'background-color: pink;'
    end
    set_meta_tags :title => @place.name
  end
  
  
end