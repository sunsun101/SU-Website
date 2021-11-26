class Tag < ApplicationRecord
  has_many :complains, dependent: :delete_all
  has_many :users, dependent: :nullify
  validates_presence_of :name
  validates :email, exclusion: { in: [nil] }
end
