class PameRecord < ActiveRecord::Migration
  def change
    add_column :gef_pame_records, :wdpa_area_id, :integer
  end
end
