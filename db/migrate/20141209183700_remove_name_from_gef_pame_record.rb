class RemoveNameFromGefPameRecord < ActiveRecord::Migration
  def change
    remove_column :gef_pame_records, :pa_name_mett
  end
end
