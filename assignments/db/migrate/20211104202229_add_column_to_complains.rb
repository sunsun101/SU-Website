class AddColumnToComplains < ActiveRecord::Migration[6.1]
  def change
    add_column :complains, :subject, :string
    add_column :complains, :updatedBy, :string
  end
end
