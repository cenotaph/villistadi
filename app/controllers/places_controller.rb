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
    if @place.description(:en) != @place.description(:fi)
      a = Hash.new
      a["en"] = url_for(@place) + "?locale=en"
      a["fi"] = url_for(@place) + "?locale=fi"
    else
      a = {}
    end

    
    set_meta_tags :title => @place.name.html_safe, 
      canonical: url_for(@place),
      og: { title: @place.name.html_safe, 
            url: url_for(@place), 
            image:    (@place.photos.empty? ? 'http://villistadi.fi/assets/vs_black_small.png' :
                     [ @place.photos.first.image.url(:box).gsub(/^https/, 'http'),
                           { secure_url: @place.photos.first.image.url(:box) } ]  
                       ) 
            },
            alternate: a
      
  end
  
  
end