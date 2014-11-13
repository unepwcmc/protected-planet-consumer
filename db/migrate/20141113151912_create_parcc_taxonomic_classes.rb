class CreateParccTaxonomicClasses < ActiveRecord::Migration
  def change
    create_table :parcc_taxonomic_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
