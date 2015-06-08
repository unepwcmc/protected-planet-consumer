class ReplaceStatAndValueColumnsInParccSpeciesTurnoversTable < ActiveRecord::Migration
  def change
    remove_column :parcc_species_turnovers, :stat
    remove_column :parcc_species_turnovers, :value

    add_column :parcc_species_turnovers, :lower, :float
    add_column :parcc_species_turnovers, :median, :float
    add_column :parcc_species_turnovers, :upper, :float
  end
end
