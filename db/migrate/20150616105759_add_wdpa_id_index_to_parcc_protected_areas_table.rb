class AddWdpaIdIndexToParccProtectedAreasTable < ActiveRecord::Migration
  def change
    add_index :parcc_protected_areas, :wdpa_id
  end
end
