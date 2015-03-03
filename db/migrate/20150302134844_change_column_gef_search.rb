class ChangeColumnGefSearch < ActiveRecord::Migration
  def change
    rename_column :gef_searches, :gef_area_id, :gef_pmis_id
  end
end
