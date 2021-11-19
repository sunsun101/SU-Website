class EventsController < ApplicationController
  def index
    @event = Event.new
    @events = Event.where('event_date >= ?', Date.today )
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
    @events = Event.where('event_date < ?', Date.today )
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :event_date, pictures: [])
    end
end
