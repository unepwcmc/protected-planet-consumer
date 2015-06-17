class AddParccProtectedAreaIdIndexToParccSuitabilityChangesTable < ActiveRecord::Migration
  def change
    add_index :parcc_suitability_changes, :parcc_protected_area_id
  end
end
