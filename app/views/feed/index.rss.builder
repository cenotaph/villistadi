xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do

    xml.title             "Villi Stadi"
    xml.description       "Helsinki's urban wild"
    xml.link              feed_url

    @feed.each do |item|
      xml.item do
        xml.title         item.name
        xml.description raw(item.body.html_safe)
        xml.link          url_for(:controller => item.class.to_s.tableize, :action => :show, :id => item.slug, :host => 'villistadi.fi')
        xml.pubDate       item.feed_date.to_s(:rfc822)
        xml.guid          url_for(:controller => item.class.to_s.tableize, :action => :show, :id => item.slug, :host => 'villistadi.fi')
        if item.respond_to?(:icon)
          if item.icon?
            xml.media :content, url: item.icon.url, type: item.icon_content_type, height: item.icon_height, width: item.icon_width
            xml.media :thumbnail, url: item.icon.url(:thumb), type: item.icon_content_type, height: 100, width: 100
          end
        end
      end
    end
  end
end