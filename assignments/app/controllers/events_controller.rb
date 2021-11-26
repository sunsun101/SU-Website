class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @selected_tag = 0
    if params[:tag_id] and params[:tag_id].to_i != 0
      @selected_tag = params[:tag_id]
      @events = Event.where('event_date >= ? and tag_id = ?', Date.today, params[:tag_id]).order('event_date DESC').page(params[:page])
    else
      @events = Event.where('event_date >= ?', Date.today ).order('event_date DESC').page(params[:page])
    end
  end

  def new
    @event = Event.new
  end

  def create 
    @event = Event.new(event_params)
    if @event.save
      if params[:event][:pictures].present?
        params[:event][:pictures].each do |image|
          @event.pictures.attach(image)
        end
      end
      flash[:success] = 'Event created successfully'
      redirect_to events_path
    else
      render :new
    end
  end

  def past_events
    @selected_month = Time.now.month
    if params[:date] and params[:date][:month]
      @selected_month = params[:date][:month].to_i
    end
    @events = Event.where('extract(month from event_date) = ? and event_date < ?', @selected_month, Date.today()).order('event_date DESC').page(params[:page])
    
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        if params[:event][:pictures].present?
          params[:event][:pictures].each do |image|
            @event.pictures.attach(image)
          end
        end
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

  def removeImage
      p "Here"
      @picture = ActiveStorage::Attachment.find(params[:id])
      @picture.purge
      redirect_back(fallback_location: request.referer)
  end

  private
    def event_params
      params.require(:event).permit(:title, :description,:tag_id, :event_date)
    end

    def set_event
      @event = Event.find(params[:id])
    end
end
