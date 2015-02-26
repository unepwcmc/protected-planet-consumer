class ChangeColumnNameGefWdpaRecord < ActiveRecord::Migration
  def change
    rename_column :gef_wdpa_records, :name, :wdpa_name
  end
end
