class Gef::PameRecordWdpaRecord < ActiveRecord::Base
  belongs_to :gef_pame_record, class_name: 'Gef::PameRecord', foreign_key: :gef_pame_record_id
  belongs_to :gef_wdpa_record, class_name: 'Gef::WdpaRecord', foreign_key: :gef_wdpa_record_id
end
