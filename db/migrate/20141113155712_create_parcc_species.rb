class CreateParccSpecies < ActiveRecord::Migration
  def change
    create_table :parcc_species do |t|
      t.integer :parcc_taxonomic_order_id
      t.string :name
      t.string :iucn_cat
      t.string :sensivity
      t.string :adaptability
      t.string :exposure_2025
      t.string :exposure_2055
      t.boolean :cc_vulnerable

      t.timestamps
    end
  end
end
