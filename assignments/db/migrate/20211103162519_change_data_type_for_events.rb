class ChangeDataTypeForEvents < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :description, :text
  end
end
