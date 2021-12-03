class Tag < ApplicationRecord
  has_many :complains, dependent: :delete_all
  has_many :su_members, dependent: :nullify
  has_many :users, dependent: :nullify
  validates_presence_of :name
  validates :email, exclusion: { in: [nil] }
  has_many :events, dependent: :delete_all
end
