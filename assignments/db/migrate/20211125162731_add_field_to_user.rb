class AddFieldToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :tag, index: true
  end
end
