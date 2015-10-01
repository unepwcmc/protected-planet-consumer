class CreateParccTaxonomicClassProtectedArea < ActiveRecord::Migration
  def change
    create_table :parcc_taxonomic_class_protected_areas do |t|
      t.integer :parcc_taxonomic_class_id
      t.integer :parcc_protected_area_id
      t.integer :count_total_species
      t.integer :count_vulnerable_species

      t.timestamps
    end
  end
end
