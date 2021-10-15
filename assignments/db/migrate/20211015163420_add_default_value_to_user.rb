class AddDefaultValueToUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :status, :string, default: 'A'
  end
end
