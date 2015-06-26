class RenameSensivityToSensitivityInParccSpecies < ActiveRecord::Migration
  def change
    rename_column :parcc_species, :sensivity, :sensitivity
  end
end
