class AddWdpaExistsToGefWdpaRecord < ActiveRecord::Migration
  def change
    add_column :gef_wdpa_records, :wdpa_exists, :boolean
  end
end
