xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    # Required to pass W3C validation.
    xml.atom :link, nil, {
      :href => feed_url,
      :rel => 'self', :type => 'application/rss+xml'
    }
  
    # Feed basics.
    xml.title             "Villi Stadi"
    xml.description       "Helsinki's urban wild"
    xml.link              feed_url
  
    # Posts.
    @feed.each do |item|
      xml.item do
        xml.title         item.name
        xml.description do  
          xml.cdata!item.body
        end
        xml.link          url_for(item)
        xml.pubDate       item.created_at.to_s(:rfc822)
        xml.guid          url_for(item)
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