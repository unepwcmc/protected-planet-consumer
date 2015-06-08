class CreateTableParccSuitabilityChanges < ActiveRecord::Migration
  def change
    create_table :parcc_suitability_changes do |t|
      t.integer :parcc_species_id
      t.integer :parcc_protected_area_id
      t.integer :year
      t.string  :value

      t.timestamps
    end
  end
end
