class AddCropToSuMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :su_members, :crop_x, :string
    add_column :su_members, :crop_y, :string
    add_column :su_members, :crop_width, :string
    add_column :su_members, :crop_height, :string
  end
end
