class Gef::PameRecord < ActiveRecord::Base
  belongs_to :gef_wdpa_record, class_name: 'Gef::WdpaRecord', foreign_key: :gef_wdpa_record_id
  belongs_to :gef_area, class_name: 'Gef::Area', foreign_key: :gef_area_id
  belongs_to :gef_pame_name, class_name: 'Gef::PameName', foreign_key: :gef_pame_name_id
  belongs_to :gef_budget_type, class_name: 'Gef::BudgetType', foreign_key: :gef_budget_recurrent_type_id
  belongs_to :gef_budget_type, class_name: 'Gef::BudgetType', foreign_key: :gef_budget_project_type_id
end