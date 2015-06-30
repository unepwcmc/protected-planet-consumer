class AddIndexesInSuitabilityChangesTable < ActiveRecord::Migration
  def change
    add_index(:parcc_suitability_changes, :value, where: "value = 'Dec' OR value = 'Inc'")
    add_index(:parcc_suitability_changes, :parcc_species_id)
  end
end
