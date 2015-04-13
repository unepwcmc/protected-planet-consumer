class CreateGefBiomes < ActiveRecord::Migration
  def change
    create_table :gef_biomes do |t|
      t.string :name

      t.timestamps
    end
  end
end
