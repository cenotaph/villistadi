class Admin::PagesController < Admin::BaseController
  responders :location, :flash
  respond_to :html, :json
  has_scope :by_city
  
  def create
    @page = Page.new(page_params)
    if @page.save
      respond_with @page, location: -> { admin_pages_path }
    end
    
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy!
    redirect_to admin_pages_path
  end
  
  def index
    @pages = apply_scopes(Page).all
    respond_to do |format|
      format.json { 
        render :json => @pages.to_json(:only => [:id, :name]), :callback => params[:callback]
      }
      format.html
    end
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      respond_with @page, location: -> { admin_pages_path }
    end
  end
  
  private
  
  def page_params
    params.require(:page).permit(:published, :slug,  :parent_id, :city_id, translations_attributes: [:id, :locale, :name, :body])
  end
  
end