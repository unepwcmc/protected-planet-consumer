class Gef::PameRecord < ActiveRecord::Base
  belongs_to :gef_wdpa_record, class_name: 'Gef::WdpaRecord', foreign_key: :gef_wdpa_record_id
end