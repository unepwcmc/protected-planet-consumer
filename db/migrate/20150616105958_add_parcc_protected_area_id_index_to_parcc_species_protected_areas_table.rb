class AddParccProtectedAreaIdIndexToParccSpeciesProtectedAreasTable < ActiveRecord::Migration
  def change
    add_index :parcc_species_protected_areas, :parcc_protected_area_id
  end
end
