class HomeController < ApplicationController
  
  def index
    @places = Place.published
    @posts = Post.no_project.published.order('published_at DESC').limit(4)
  end
  
  def map_search
    @lat =  params[:lat]
    @lng =  params[:lng]
    
    @location = params[:location]
    @hits = Place.find_by_sql("select * from ( SELECT id, slug, centre_lat, centre_lng, sw_lat, sw_lng, ne_lat, ne_lng, ( 6371 * acos( cos( radians(#{@lat}) ) * cos( radians( centre_lat) ) * cos( radians( centre_lng ) - radians(#{@lng}) ) + sin( radians(#{@lat}) ) * sin( radians( centre_lat ) ) ) ) AS distance FROM places group by id) ss where distance < 1 order by distance")
    if @hits.empty?
      @hits = Place.find_by_sql("select * from ( SELECT id, slug, centre_lat, centre_lng, sw_lat, sw_lng, ne_lat, ne_lng, ( 6371 * acos( cos( radians(#{@lat}) ) * cos( radians( centre_lat) ) * cos( radians( centre_lng ) - radians(#{@lng}) ) + sin( radians(#{@lat}) ) * sin( radians( centre_lat ) ) ) ) AS distance FROM places group by id) ss where distance < 2.5 order by distance")
    end
    if @hits.empty?
      @hits = Place.find_by_sql("select * from ( SELECT id, slug, centre_lat, centre_lng, sw_lat, sw_lng, ne_lat, ne_lng, ( 6371 * acos( cos( radians(#{@lat}) ) * cos( radians( centre_lat) ) * cos( radians( centre_lng ) - radians(#{@lng}) ) + sin( radians(#{@lat}) ) * sin( radians( centre_lat ) ) ) ) AS distance FROM places group by id) ss where distance < 5 order by distance")
    end
    
    render :format => :js
  end
  
end