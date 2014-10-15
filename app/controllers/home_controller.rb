class HomeController < ApplicationController
  
  def index
    @places = Place.published
    @posts = Post.published.order('published_at DESC').limit(4)
  end
  
end