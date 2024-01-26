class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :gender, size: 1
      t.date :birthday
      t.references :user, null: true, foreign_key: true
      t.references :species, null: true, foreign_key: true

      t.timestamps
    end
  end
end
