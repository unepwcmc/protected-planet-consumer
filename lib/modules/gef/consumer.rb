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
      designation: @full_api_data[:designation][:name],
      designation_type: @full_api_data[:designation][:jurisdiction][:name],
      iucn_category: @full_api_data[:iucn_category][:name],
      governance: @full_api_data[:governance][:name],
      reported_area: @full_api_data[:reported_area],
      status: @full_api_data[:legal_status][:name],
      status_year: @full_api_data[:legal_status_updated_at].year,
      iso_3: @full_api_data[:countries][0][:iso_3],
      region: @full_api_data[:countries][0][:region][:name]
    }
  end
end