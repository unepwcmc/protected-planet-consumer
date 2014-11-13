class CreateParccSpeciesTurnovers < ActiveRecord::Migration
  def change
    create_table :parcc_species_turnovers do |t|
      t.integer :parcc_protected_area_id
      t.string :taxonomic_class
      t.integer :year
      t.string :stat
      t.float :value

      t.timestamps
    end
  end
end