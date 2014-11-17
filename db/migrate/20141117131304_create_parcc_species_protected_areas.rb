class CreateParccSpeciesProtectedAreas < ActiveRecord::Migration
  def change
    create_table :parcc_species_protected_areas do |t|
      t.integer :parcc_species_id
      t.integer :parcc_protected_areas_id
      t.integer :parcc_chenge_type_id
      t.float :intersection_area
      t.float :overlap_percentage

      t.timestamps
    end
  end
end
