class CreateGefRegions < ActiveRecord::Migration
  def change
    create_table :gef_regions do |t|
      t.string :name

      t.timestamps
    end
  end
end
