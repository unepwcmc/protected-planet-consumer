class CreateGefPameRecordWdpaRecords < ActiveRecord::Migration
  def change
    create_table :gef_pame_record_wdpa_records do |t|
      t.integer :gef_pame_record_id
      t.integer :gef_wdpa_record_id

      t.timestamps
    end
  end
end
