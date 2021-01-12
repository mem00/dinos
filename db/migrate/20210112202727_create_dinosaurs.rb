class CreateDinosaurs < ActiveRecord::Migration[6.0]
  def change
    create_table :dinosaurs do |t|
      t.string :name, null: false
      t.string :species, null: false
      t.references :cage, foreign_key: true, index: true

      t.timestamps
    end
  end
end
