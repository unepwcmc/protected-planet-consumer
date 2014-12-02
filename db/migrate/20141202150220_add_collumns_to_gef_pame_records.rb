class AddCollumnsToGefPameRecords < ActiveRecord::Migration
  def change
    add_column :gef_pame_records, :primary_biome, :string
    add_column :gef_pame_records, :primary_biome_area, :string
    add_column :gef_pame_records, :secondary_biome, :string
    add_column :gef_pame_records, :secondary_biome_area, :string
    add_column :gef_pame_records, :tertiary_biome, :string
    add_column :gef_pame_records, :tertiary_biome_area, :string
    add_column :gef_pame_records, :quaternary_biome, :string
    add_column :gef_pame_records, :quaternary_biome_area, :string
  end
end
