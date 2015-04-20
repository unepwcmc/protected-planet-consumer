class ChangeBiomesOngefPameRecords < ActiveRecord::Migration
  def change
    remove_column :gef_pame_records, :primary_biome
    remove_column :gef_pame_records, :secondary_biome
    remove_column :gef_pame_records, :tertiary_biome
    remove_column :gef_pame_records, :quaternary_biome
    add_column :gef_pame_records, :primary_biome_id, :integer
    add_column :gef_pame_records, :secondary_biome_id, :integer
    add_column :gef_pame_records, :tertiary_biome_id, :integer
    add_column :gef_pame_records, :quaternary_biome_id, :integer
  end
end
