class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :family_id
      t.date :date_of_birth
      t.integer :rating
      t.boolean :active

      t.timestamps
    end
  end
end
