class CreateGefColumnMatches < ActiveRecord::Migration
  def change
    create_table :gef_column_matches do |t|
      t.string :model_columns
      t.string :type
      t.text :xls_columns

      t.timestamps
    end
  end
end
