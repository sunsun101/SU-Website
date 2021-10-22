class SuMember < ApplicationRecord
    has_one_attached :avatar
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :designation
    validates_presence_of :nationality
    validates_presence_of :department
    validates_presence_of :program
end
