class CreateModelGefColumnMatch < ActiveRecord::Migration
  def change
    create_table :model_gef_column_matches do |t|
      t.string :model_columns
      t.string :type
      t.text :xls_columns
    end
  end
end
