class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      flash[:success] = "Event '#{@event.name}' created!"
      redirect_to @event
    else
      flash[:alert] = "Unable to create event!!!"
      render 'new'
    end
  end

  def rsvp
    @event = Event.find(params[:id])
    if @event.attendees.include?(current_user)
      redirect_to @event, notice: "You are already on the list!"
    else
      @event.attendees << current_user
      redirect_to @event
    end
  end

  def cancel_rsvp
    @event = Event.find(params[:id])
    @event.attendees.delete(current_user)
    redirect_to @event, notice: "You are no longer attending this event!"
  end

  private
  def event_params
    params.require(:event).permit(:name, :location, :date)
  end
end
