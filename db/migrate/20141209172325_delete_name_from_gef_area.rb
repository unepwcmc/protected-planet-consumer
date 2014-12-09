class DeleteNameFromGefArea < ActiveRecord::Migration
  def change
    remove_column :gef_areas, :name
  end
end
