class RemoveGefAreaIdToGefPameRecord < ActiveRecord::Migration
  def change
    remove_column :gef_pame_records, :gef_area_id
  end
end
