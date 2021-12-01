class SiteController < ApplicationController
    def index 
        @events = Event.where('event_date >= ?', Date.today ).order('event_date DESC').last(4)
    end
end
