class Admin::MenusController < Admin::BaseController
  responders :location, :flash
  respond_to :html
  
  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      respond_with @menu, location: -> { admin_menus_path }
    end
    
  end
  
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy!
    redirect_to admin_menus_path
  end
  

  def index
  end
  
  def new
    @menu = Menu.new
    if params[:parent_id]
      @menu.parent = Menu.find(params[:parent_id])
    end
  end
  
  def reorder
    @parent = Menu.find(params[:id])
  end
  
  def sort
    
    @menus = Menu.all
    @menus.each do |menu|
      next if params['menu'].index(menu.id.to_s).nil?
      menu.sort_order = params['menu'].index(menu.id.to_s) + 1
      menu.save
    end
    render nothing: true
  end
  
  def update
    @menu = Menu.find(params[:id])
    if @menu.update_attributes(menu_params)
      respond_with @menu, location: -> { admin_menus_path }
    end
  end
  
  private
  
  def menu_params
    params.require(:menu).permit(:item_type, :item_id, :published, :url, :parent_id, :sort_order, :city_id)
  end
end
