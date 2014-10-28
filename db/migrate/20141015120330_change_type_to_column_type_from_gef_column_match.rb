class ChangeTypeToColumnTypeFromGefColumnMatch < ActiveRecord::Migration
  def change
    rename_column :gef_column_matches, :type, :column_type
  end
end
