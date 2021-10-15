class ChangeUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :status, :string
  end
end
