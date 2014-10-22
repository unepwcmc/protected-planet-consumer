class RemovesColumnTypeFromGefColumnMatches < ActiveRecord::Migration
  def change
    remove_column :gef_column_matches, :column_type
  end
end
