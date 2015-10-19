class AddBackCountColumnsToParccProtectedAreas < ActiveRecord::Migration
  def change
    add_column :parcc_protected_areas, :count_total_species, :integer, default: 0
    add_column :parcc_protected_areas, :count_vulnerable_species, :integer, default: 0
  end
end
