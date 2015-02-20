class AddBudgetsToGefPameRecords < ActiveRecord::Migration
  def change
    add_column :gef_pame_records, :budget_recurrent_type_id, :integer
    add_column :gef_pame_records, :budget_recurrent_value, :float
    add_column :gef_pame_records, :budget_project_type_id, :integer
    add_column :gef_pame_records, :budget_project_value, :float
  end
end
