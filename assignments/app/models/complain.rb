class Complain < ApplicationRecord
  paginates_per 10
  has_many_attached :com_pics
  belongs_to :tag
  belongs_to :user
  validates_presence_of :detail
  validates_presence_of :status
  validates_presence_of :tag_id
  validates_presence_of :subject
end
