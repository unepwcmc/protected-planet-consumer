class ProtectedArea < ActiveRecord::Migration
  def change
    remove_column :gef_protected_areas, :gef_pmis_id
  end
end
