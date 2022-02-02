class EventsController < ApplicationController
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
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:success] = "Event '#{event.name}' created!"
      redirect_to @event
    else
      flash[:alert] = "Unable to create event!!!"
      render 'new'
    end
  end
end
