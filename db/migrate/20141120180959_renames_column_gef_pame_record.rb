class RenamesColumnGefPameRecord < ActiveRecord::Migration
  def change
    rename_column :gef_pame_records, :wdpa_area_id, :gef_wdpa_record_id
  end
end
