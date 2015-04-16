class BiomeColumnName < ActiveRecord::Migration
  def change
    remove_column :gef_searches, :primary_biome
    add_column :gef_searches, :primary_biome_id, :integer
  end
end
