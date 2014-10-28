class Gef::Consumer

  DIRECT_VALUES = [:wdpa_id, :name, :legal_status_updated_at]
  ONLY_NAME = [:iucn_category, :legal_status, :governance]

  def api_data wdpa_id: wdpa_id
    reader = ProtectedPlanetReader.new
    @full_api_data = reader.protected_area_from_wdpaid(id: wdpa_id)
    conversion
  end

  def conversion
    {
      wdpa_id: @full_api_data[:wdpa_id],
      wdpa_pa_name: @full_api_data[:name],
      wdpa_designation: @full_api_data[:designation][:name],
      wdpa_designation_type: @full_api_data[:designation][:jurisdiction][:name],
      wdpa_iucn_category: @full_api_data[:iucn_category][:name],
      wdpa_governance: @full_api_data[:governance][:name],
      wdpa_reported_area: @full_api_data[:reported_area],
      wdpa_status: @full_api_data[:legal_status][:name],
      wdpa_status_year: Date.parse(@full_api_data[:legal_status_updated_at]).year,
      wdpa_iso_3: @full_api_data[:countries][0][:iso_3],
      wdpa_region: @full_api_data[:countries][0][:region][:name]
    }
  end
end