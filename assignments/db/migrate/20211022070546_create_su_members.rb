class CreateSuMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :su_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :designation
      t.string :nationality
      t.string :department
      t.string :program

      t.timestamps
    end
  end
end
