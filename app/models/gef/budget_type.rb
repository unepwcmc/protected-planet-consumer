class Gef::BudgetType < ActiveRecord::Base
  has_many :gef_pame_records, class_name: 'Gef::PameRecord', foreign_key: :budget_recurrent_type_id
  has_many :gef_pame_records, class_name: 'Gef::PameRecord', foreign_key: :budget_project_type_id
end