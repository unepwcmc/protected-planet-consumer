class WdpaRecord < ActiveRecord::Migration
  def change
    add_column :gef_wdpa_records, :name, :string 
    add_column :gef_wdpa_records, :original_name, :string 
    add_column :gef_wdpa_records, :marine, :boolean 
    add_column :gef_wdpa_records, :reported_area, :numeric 
    add_column :gef_wdpa_records, :sub_location, :string 
    add_column :gef_wdpa_records, :iucn_category, :string 
    add_column :gef_wdpa_records, :designation, :string 
    add_column :gef_wdpa_records, :jurisdiction, :string 
    add_column :gef_wdpa_records, :legal_status, :string 
    add_column :gef_wdpa_records, :governance, :string
  end
end
