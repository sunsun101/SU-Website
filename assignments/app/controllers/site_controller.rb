class SiteController < ApplicationController
    def index 
        @events = Event.order('event_date').last(3)
    end
end
