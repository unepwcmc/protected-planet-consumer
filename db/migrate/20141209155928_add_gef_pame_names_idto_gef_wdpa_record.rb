class AddGefPameNamesIdtoGefWdpaRecord < ActiveRecord::Migration
  def change
    add_column :gef_wdpa_records, :gef_pame_name_id, :integer
  end
end
