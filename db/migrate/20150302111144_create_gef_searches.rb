class CreateGefSearches < ActiveRecord::Migration
  def change
    create_table :gef_searches do |t|
      t.integer :gef_country_id
      t.integer :gef_region_id
      t.string :primary_biome
      t.integer :gef_area_id
      t.integer :wdpa_id
      t.string :wdpa_name

      t.timestamps
    end
  end
end
