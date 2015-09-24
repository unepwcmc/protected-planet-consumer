class RemoveCountColumnsFromParccProtectedAreas < ActiveRecord::Migration
  def change
    remove_column :parcc_protected_areas, :count_total_species
    remove_column :parcc_protected_areas, :count_vulnerable_species
  end
end
