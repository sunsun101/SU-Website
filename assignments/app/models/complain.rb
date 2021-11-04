class Complain < ApplicationRecord
  belongs_to :tag
  belongs_to :user
  has_many_attached :picture
  validates_presence_of :detail
  validates_presence_of :tag_id
end
