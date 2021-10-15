class AddCheckConstraintToUser < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :users, "status IN ('A', 'D')", name: 'status_check'
  end
end
