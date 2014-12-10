class CreateGefPameNames < ActiveRecord::Migration
  def change
    create_table :gef_pame_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
