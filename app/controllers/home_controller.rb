class HomeController < ApplicationController
  
  def index
    @places = Place.published
    @posts = Post.no_project.published.order('published_at DESC').limit(4)
  end
  
  def map_search
    logger.warn('params are '  + params.inspect)
  end
  
end