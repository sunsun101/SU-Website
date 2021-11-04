class Tag < ApplicationRecord
  has_many :complains, dependent: :delete_all
  validates_presence_of :name
end