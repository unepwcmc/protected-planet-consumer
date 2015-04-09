class Gef::Api::Area < ActiveRecord::Base
  def find_areas params: params
    areas =  Gef::WdpaRecord.joins({gef_area: :gef_pame_records}, :gef_pame_name)
    areas = areas.where(gef_areas: {gef_pmis_id: params[:gef_pmis_id]}) if params[:gef_pmis_id].present?
    areas = areas.joins(gef_countries: :gef_region).where(gef_countries: {id: gef_country_id}) if gef_country_id.present?
    areas = areas.joins(gef_countries: :gef_region).where(gef_countries: {gef_region_id: gef_region_id}) if gef_region_id.present?
    areas = areas.where(gef_pame_records: {primary_biome: primary_biome}) if primary_biome.present?
    areas = areas.where(wdpa_name: wdpa_name) if wdpa_name.present?

    all_data = []
    areas.each do |pa|
      protected_area = pa.attributes.symbolize_keys!
      protected_area.merge!( pa.gef_area.attributes.symbolize_keys! )
      protected_area[:protected_planet_url] = protected_planet_url wdpa_id: protected_area[:wdpa_id]
      protected_area[:wdpa_name] = protected_area[:wdpa_exists] ? protected_area[:wdpa_name] : pa.gef_pame_name.name
      all_data << protected_area
    end
    all_data.uniq!
    all_data
  end

  def protected_planet_url wdpa_id: wdpa_id
    PP_BASE_URL + wdpa_id.to_s
  end


end