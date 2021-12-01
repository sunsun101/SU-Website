class Event < ApplicationRecord
    has_many_attached :pictures
    validates_presence_of :title
    validates_presence_of :description
    validates_presence_of :event_date
    belongs_to :tag, optional: true 
    paginates_per 9
end
