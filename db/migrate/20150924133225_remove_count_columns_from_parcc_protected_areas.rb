class RemoveCountColumnsFromParccProtectedAreas < ActiveRecord::Migration
  def change
    remove_column :parcc_protected_areas, :count_total_species, :integer
    remove_column :parcc_protected_areas, :count_vulnerable_species, :integer
  end
end
