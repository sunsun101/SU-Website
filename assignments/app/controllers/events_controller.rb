class EventsController < ApplicationController
  def index
    @event = Event.new
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create 
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = 'Event created successfully'
      redirect_to events_path
    else
      render :new
    end
  end

  def past_events
    
    
    @past_event = Event
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :event_date, pictures: [])
    end
end
