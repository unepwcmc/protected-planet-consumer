class CreateParcSpeciesTurnovers < ActiveRecord::Migration
  def change
    create_table :parc_species_turnovers do |t|
      t.string :taxonomic_class
      t.integer :year
      t.string :stat
      t.float :value

      t.timestamps
    end
  end
end
