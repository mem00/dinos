class CreateCages < ActiveRecord::Migration[6.0]
  def change
    create_table :cages do |t|
      t.string :power_status, null: false, default: "down"
      t.boolean :contains_carnivores, null: false, default: false
      t.string :species

      t.timestamps
    end
  end
end
