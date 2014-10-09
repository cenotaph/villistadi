class HomeController < ApplicationController
  
  def index
    @places = Place.published
  end
  
end