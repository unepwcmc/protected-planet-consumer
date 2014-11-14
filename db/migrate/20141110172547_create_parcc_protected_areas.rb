class CreateParccProtectedAreas < ActiveRecord::Migration
  def change
    create_table :parcc_protected_areas do |t|
      t.integer :parcc_id
      t.string :name
      t.string :iso_3
      t.integer :poly_id
      t.string :designation
      t.string :geom_type
      t.string :iucn_cat
      t.integer :wdpa_id

      t.timestamps
    end
  end
end
