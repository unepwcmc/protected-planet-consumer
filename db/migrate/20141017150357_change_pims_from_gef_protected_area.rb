class ChangePimsFromGefProtectedArea < ActiveRecord::Migration
  def change
    rename_column :gef_protected_areas, :gef_pims_id, :gef_pmis_id
  end
end
