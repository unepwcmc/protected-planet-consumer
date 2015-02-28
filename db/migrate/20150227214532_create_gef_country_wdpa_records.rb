class CreateGefCountryWdpaRecords < ActiveRecord::Migration
  def change
    create_table :gef_country_wdpa_records do |t|
      t.integer :gef_wdpa_record_id
      t.integer :gef_country_id

      t.timestamps
    end
  end
end
