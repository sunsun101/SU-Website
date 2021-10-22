class CreateComplains < ActiveRecord::Migration[6.1]
  def change
    create_table :complains do |t|
      t.text :detail
      t.references :tag, null: false, foreign_key: true
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
