class EventsController < ApplicationController
  def index
    @event = Event.new
    @events = Event.all
  end

  def create 
    event = Event.create!(event_params)
    redirect_to events_path
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :event_date, pictures: [])
    end
end
