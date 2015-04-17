class Gef::Search < ActiveRecord::Base

  PP_BASE_URL = 'http://www.protectedplanet.net/sites/'

  def areas
    @areas ||= find_areas type: 'page'
  end

  def to_csv
    @areas ||= find_areas  type: 'csv'
    csv = []
    csv_headers = []
    @areas.each do |protected_area|
      csv << protected_area.values
      csv_headers = protected_area.keys
    end
    csv.insert(0,csv_headers)
  end
  
private

  def find_areas type: type
    areas = query_areas
    all_data = information areas: areas, type: type
    all_data
  end

  def query_areas
    areas =  Gef::PameRecord.joins(:gef_area, :gef_pame_name, :gef_wdpa_records)
    areas = areas.where(gef_areas: {gef_pmis_id: gef_pmis_id}) if gef_pmis_id.present?
    areas = areas.joins(gef_wdpa_records: { gef_countries: :gef_region }).where(gef_countries: {id: gef_country_id}) if gef_country_id.present?
    areas = areas.joins(gef_wdpa_records: { gef_countries: :gef_region }).where(gef_countries: {gef_region_id: gef_region_id}) if gef_region_id.present?
    areas = areas.joins(:primary_biome).where(gef_biomes: { id: primary_biome_id}) if primary_biome_id.present?
    areas = areas.where(gef_wdpa_records: {wdpa_name: wdpa_name}) if wdpa_name.present?
    areas = areas.where(gef_wdpa_records: {wdpa_id: wdpa_id}) if wdpa_id.present?
    areas
  end

  def information areas: areas, type: type
    @all_data = []
    areas.each do |pa|
      pa.gef_wdpa_records.each do |wdpa_area|
        protected_area = pa.attributes.symbolize_keys!
        protected_area.merge!( pa.gef_area.attributes.symbolize_keys! )
        protected_area.merge!( pa.gef_pame_name.attributes.symbolize_keys! )
        protected_area.merge!( wdpa_area.attributes.symbolize_keys! )
        protected_area[:protected_planet_url] = protected_planet_url wdpa_id: protected_area[:wdpa_id]
        protected_area[:wdpa_name] = protected_area[:wdpa_exists] ? protected_area[:wdpa_name] : pa.gef_pame_name.name
        if type == 'page'
          @all_data << protected_area.slice(:gef_pmis_id, :wdpa_id, :wdpa_name, :wdpa_exists, :protected_planet_url)
        else
          @all_data << protected_area
        end
      end
    end
    @all_data.uniq!
    @all_data
  end

  def protected_planet_url wdpa_id: wdpa_id
    PP_BASE_URL + wdpa_id.to_s
  end
end
