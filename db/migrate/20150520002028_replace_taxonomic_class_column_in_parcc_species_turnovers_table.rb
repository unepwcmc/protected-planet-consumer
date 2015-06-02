class ReplaceTaxonomicClassColumnInParccSpeciesTurnoversTable < ActiveRecord::Migration
  def change
    remove_column :parcc_species_turnovers, :taxonomic_class
    add_column :parcc_species_turnovers, :taxonomic_class_id, :integer
  end
end
