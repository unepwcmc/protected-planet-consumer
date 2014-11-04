class RenameGefProtectedAreaToGefPpArea < ActiveRecord::Migration
  def change
    rename_table :gef_protected_areas, :gef_wdpa_records
  end
end
