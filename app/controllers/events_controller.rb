class EventsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = t(:event_will_be_reviewed)
      redirect_to '/calendar'
    else
      flash[:error] = t(:error_creating_event, :errors => @event.errors.full_messages.join('; '))
      render :template => 'events/new'
    end
  end
  
  def new
    @event = Event.new
  end
  
  def show
    @event = Event.find(params[:id])
    if @event.approved
      render
    else
      if user_signed_in?
        if current_user.has_role? :goddess
          render
        else
          flash[:error] = t :you_have_no_permission
          redirect_to '/calendar'
        end
      else
        redirect_to '/calendar'
      end
    end
  end
  
  protected
  
  def event_params
    params.require(:event).permit([:user_id, :project_id, :title,  :contact_name, :contact_contact, :description, :start_at, :end_at, :address1, :address2, :weblink, :city, :postcode, :venue])
  end
  
end