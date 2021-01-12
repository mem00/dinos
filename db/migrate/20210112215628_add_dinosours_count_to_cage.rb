class AddDinosoursCountToCage < ActiveRecord::Migration[6.0]
  def change
    add_column :cages, :dinosaurs_count, :integer, default: 0
  end
end
