class CreateGefAreas < ActiveRecord::Migration
  def change
    create_table :gef_areas do |t|
      t.integer :gef_pmis_id

      t.timestamps
    end
  end
end
