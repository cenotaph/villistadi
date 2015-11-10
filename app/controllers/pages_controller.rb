class PagesController < ApplicationController
  def show  
    @page = Page.find(params[:id])
    
    if @page.body(:en) != @page.body(:fi)
      a = Hash.new
      a["en"] = url_for(@page) + "?locale=en"
      a["fi"] = url_for(@page) + "?locale=fi"
    else
      a = {}
    end

    
    set_meta_tags :title => @page.name.html_safe, 
      canonical: url_for(@page),
      og: { title: @page.name.html_safe, 
            url: url_for(@page), 
            image:            'http://villistadi.fi/assets/vs_black_small.png'
          },
      alternate: a
                  
  end
end