class FeedController < ApplicationController
  
  def index
    @feed = Post.published.order(published_at: :desc).limit(25)
    @feed << Event.approved.limit(25)
    @feed = @feed.flatten.sort_by{|x| x.feed_date }.reverse[0..19]
    respond_to do |format|
      format.any do
        render :action => 'index.rss.builder', :layout => false
      end
    end
  
  end
  
end