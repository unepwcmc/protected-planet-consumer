class AddParccProtectedAreaIdIndexToParccSpeciesTurnoversTable < ActiveRecord::Migration
  def change
    add_index :parcc_species_turnovers, :parcc_protected_area_id
  end
end
