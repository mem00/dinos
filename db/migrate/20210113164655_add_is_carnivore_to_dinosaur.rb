class AddIsCarnivoreToDinosaur < ActiveRecord::Migration[6.0]
  def change
    add_column :dinosaurs, :is_carnivore, :boolean, default: false
  end
end
