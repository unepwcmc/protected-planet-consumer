class CreateGefBudgetTypes < ActiveRecord::Migration
  def change
    create_table :gef_budget_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
