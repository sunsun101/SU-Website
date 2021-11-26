class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

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

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.pictures&.purge
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :event_date, pictures: [])
    end

    def set_event
      @event = Event.find(params[:id])
    end
end
