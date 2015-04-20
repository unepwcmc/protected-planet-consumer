class Gef::CountryWdpaRecord < ActiveRecord::Base
  belongs_to :gef_country, class_name: 'Gef::Country', foreign_key: :gef_country_id
  belongs_to :gef_wdpa_record, class_name: 'Gef::WdpaRecord', foreign_key: :gef_wdpa_record_id
end
