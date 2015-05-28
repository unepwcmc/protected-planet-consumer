class Gef::Api::Area < ActiveRecord::Base

  PP_BASE_URL = 'http://www.protectedplanet.net/sites/'

  def self.area_finder params: params
    @params = params
    @areas ||= find_areas type: 'json'
  end
    
  private

  def self.find_areas type: type
    areas = areas_querier
    all_data = information areas: areas, type: type
    all_data
  end

  def self.areas_querier
    areas =  Gef::PameRecord.joins(:gef_area, :gef_pame_name, :gef_wdpa_records, :budget_recurrent_type, :budget_project_type)
    areas = areas.where(gef_areas: {gef_pmis_id: @params[:gef_pmis_id]}) if @params[:gef_pmis_id].present?
    areas = areas.joins(gef_wdpa_records: { gef_countries: :gef_region }).where(gef_countries: {id: @params[:gef_country_id]}) if @params[:gef_country_id].present?
    areas = areas.joins(gef_wdpa_records: { gef_countries: :gef_region }).where(gef_countries: {gef_region_id: @params[:gef_region_id]}) if @params[:gef_region_id].present?
    areas = areas.joins(:primary_biome).where(gef_biomes: { id: @params[:primary_biome_id]}) if @params[:primary_biome_id].present?
    areas = areas.where(gef_wdpa_records: {wdpa_name: @params[:wdpa_name]}) if @params[:wdpa_name].present?
    areas = areas.where(gef_wdpa_records: {wdpa_id: @params[:wdpa_id]}) if @params[:wdpa_id].present?
    areas
  end

  def self.information areas: areas, type: type
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

  def self.protected_planet_url wdpa_id: wdpa_id
    PP_BASE_URL + wdpa_id.to_s
  end


end