class ChangeColumnGefCountry < ActiveRecord::Migration
  def change
    rename_column :gef_countries, :region_id, :gef_region_id    
  end
end
