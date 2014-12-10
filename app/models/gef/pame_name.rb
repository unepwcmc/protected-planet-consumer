class Gef::PameName < ActiveRecord::Base
  has_many :gef_wdpa_records, class_name: 'Gef::WdpaRecord', foreign_key: :gef_pame_name_id
  has_many :gef_pame_records, class_name: 'Gef::PameRecord', foreign_key: :gef_pame_name_id
  validates_uniqueness_of :name
end
