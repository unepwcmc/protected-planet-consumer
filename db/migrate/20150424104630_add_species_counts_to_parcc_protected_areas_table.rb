class AddSpeciesCountsToParccProtectedAreasTable < ActiveRecord::Migration
  def change
    add_column :parcc_protected_areas, :count_total_species, :integer
    add_column :parcc_protected_areas, :count_vulnerable_species, :integer
    add_column :parcc_protected_areas, :percentage_vulnerable_species, :integer
  end
end
