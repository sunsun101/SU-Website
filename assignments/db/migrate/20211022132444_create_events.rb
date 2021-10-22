class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :event_date
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
