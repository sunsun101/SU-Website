class AddFieldToSuMembers < ActiveRecord::Migration[6.1]
  def change
    add_reference :su_members, :tag, index: true
  end
end
