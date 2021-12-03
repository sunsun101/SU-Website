class SuMember < ApplicationRecord
  belongs_to :tag, optional: true
  has_one_attached :avatar
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :designation
  validates_presence_of :nationality
  validates_presence_of :department
  validates_presence_of :program
  validates_presence_of :tag_id

  def crop_constraints
    return {} unless crop_x && crop_y && crop_width && crop_height

    {
      crop:
        [
          crop_x.to_f,
          crop_y.to_f,
          (crop_width + crop_x).to_f,
          (crop_height + crop_y).to_f
        ]
    }
  end
end
