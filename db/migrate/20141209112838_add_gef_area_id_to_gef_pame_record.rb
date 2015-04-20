class AddGefAreaIdToGefPameRecord < ActiveRecord::Migration
  def change
    add_column :gef_pame_records, :gef_area_id, :integer
  end
end
