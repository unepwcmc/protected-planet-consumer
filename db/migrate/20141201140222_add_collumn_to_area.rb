class AddCollumnToArea < ActiveRecord::Migration
  def change
    add_column :gef_areas, :name, :string
  end
end
