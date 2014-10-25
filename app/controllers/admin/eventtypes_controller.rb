class Admin::EventtypesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  load_and_authorize_resource 
  skip_before_filter :require_no_authentication
  responders :location, :flash
  respond_to :html, :json

  
  def create
    @eventtype = Eventtype.new(eventtype_params)
    if @eventtype.save
      respond_with @eventtype, location: -> { admin_eventtypes_path }
    end
  end
  
  def destroy
    @eventtype = Eventtype.find(params[:id])
    @eventtype.destroy!
    redirect_to admin_eventtypes_path
  end
  
  def index
    @eventtypes = Eventtype.all
    set_meta_tags :title => t(:event_types)
  end

  
  def new
    @eventtype = Eventtype.new
    set_meta_tags :title => t(:new_event_type)
  end
  
  def update
    @eventtype = Eventtype.find(params[:id])
    if @eventtype.update_attributes(eventtype_params)
      respond_with @eventtype, location: -> { admin_eventtypes_path }
    end
  end
  
  private
  
  def eventtype_params
    params.require(:eventtype).permit([:colour_code, translations_attributes: [:id, :locale, :name]])
  end
  
end