class Gef::WdpaRecord < ActiveRecord::Base
  belongs_to :gef_area, class_name: 'Gef::Area', foreign_key: :gef_area_id
  has_many :gef_pame_records, class_name: 'Gef::PameRecord', foreign_key: :gef_wdpa_record_id


  PP_BASE_URL = 'http://www.protectedplanet.net/sites/'

  def self.wdpa_name gef_pmis_id: gef_pmis_id
    consumer = Gef::Consumer.new
    wdpa_areas = Gef::WdpaRecord.joins(:gef_area).where('gef_areas.gef_pmis_id = ?', gef_pmis_id)
    wdpa_data = []
    wdpa_areas.each do |pa|
      pa_data = {}
      api_data = consumer.api_data(wdpa_id: pa.wdpa_id) rescue {wdpa_data: {name: 'Not Available in WDPA'}}
      pa_data[:protected_planet_url] = protected_planet_url wdpa_id: pa.wdpa_id
      pa_data[:wdpa_name] = api_data[:wdpa_data][:name]
      pa_data[:wdpa_id] = pa.wdpa_id
      wdpa_data << pa_data
    end
    wdpa_data
  end

  private

  def self.protected_planet_url wdpa_id: wdpa_id
    PP_BASE_URL + wdpa_id.to_s
  end
end
