class AddGefPameNamesIdtoGefPameRecord < ActiveRecord::Migration
  def change
    add_column :gef_pame_records, :gef_pame_name_id, :integer
  end
end
