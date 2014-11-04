class AddGefAreaIdToGefProtectedArea < ActiveRecord::Migration
  def change
    add_column :gef_protected_areas, :gef_area_id, :integer
  end
end
