class CreateParccTaxonomicOrders < ActiveRecord::Migration
  def change
    create_table :parcc_taxonomic_orders do |t|
      t.integer :parcc_taxonomic_class_id
      t.string :name

      t.timestamps
    end
  end
end
