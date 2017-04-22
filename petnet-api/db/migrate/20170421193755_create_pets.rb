class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :animal
      t.string :breed
      t.string :created_by

      t.timestamps
    end
  end
end
