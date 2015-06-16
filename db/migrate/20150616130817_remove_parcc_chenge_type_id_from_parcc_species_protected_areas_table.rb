class RemoveParccChengeTypeIdFromParccSpeciesProtectedAreasTable < ActiveRecord::Migration
  def change
    remove_column :parcc_species_protected_areas, :parcc_chenge_type_id
  end
end
