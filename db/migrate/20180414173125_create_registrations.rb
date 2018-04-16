class CreateRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :registrations do |t|
      t.string :camp_id
      t.string :student_id
      t.text :payment

      t.timestamps
    end
  end
end
