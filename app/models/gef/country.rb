class Gef::Country < ActiveRecord::Base
  belongs_to :gef_region, class_name: 'Gef::Region', foreign_key: :gef_region_id
  has_many :gef_wdpa_records, class_name: 'Gef::WdpaRecord', through: :gef_country_wdpa_records
  has_many :gef_country_wdpa_records, class_name: 'Gef::CountryWdpaRecord', foreign_key: :gef_country_id
end
