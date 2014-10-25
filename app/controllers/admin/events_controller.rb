class Admin::EventsController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
  #load_and_authorize_resource
  # check_authorization
  load_and_authorize_resource 
  skip_before_filter :require_no_authentication
  
  responders :location, :flash
  respond_to :html, :json
  has_scope :approved, type: :boolean
  has_scope :unapproved, type: :boolean
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy!
    redirect_to admin_events_path
  end
  
  def index
    @events = apply_scopes(Event).page(params[:page]).per(50)
    set_meta_tags :title => t(:events)
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      respond_with @event, location: -> { admin_events_path }
    end
  end
  
  protected
  
  def event_params
    params.require(:event).permit([:user_id, :project_id, :title, :eventtype_id, :weblink, :contact_name, :contact_contact, :description, :start_at, :end_at, :address1, :address2, :city, :approved, :postcode, :venue])
  end
  
  
end