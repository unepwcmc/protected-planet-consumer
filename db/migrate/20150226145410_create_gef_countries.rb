class CreateGefCountries < ActiveRecord::Migration
  def change
    create_table :gef_countries do |t|
      t.integer :region_id
      t.string :name
      t.string :iso_3

      t.timestamps
    end
  end
end
