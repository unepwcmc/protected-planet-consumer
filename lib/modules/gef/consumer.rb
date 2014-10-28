class Gef::Consumer

  DIRECT_VALUES = [:wdpa_id, :pa_name, :reported_area]
  WITH_NAME = [:designation, :iucn_category, :governance, :legal_status]

  def api_data wdpa_id: wdpa_id
    reader = ProtectedPlanetReader.new
    @full_api_data = reader.protected_area_from_wdpaid(id: wdpa_id)
    @consumer_data = {}
    direct_values && designation_type && only_name && status_year && countries 
    { wdpa_data: @consumer_data }
  end

  def direct_values
    DIRECT_VALUES.each do |value|
      @consumer_data[value] =  @full_api_data[value]
    end
  end

  def only_name
    WITH_NAME.each do |value|
      @consumer_data[value] =  @full_api_data[value][:name]
    end
  end

  def countries
    countries = []
    @full_api_data[:countries].each do |country|
      countries << {
        name: country[:name],
        iso_3: country[:iso_3],
        region: country[:region][:name]
      }
    end
    @consumer_data[:countries] = countries
  end

  def status_year
    @consumer_data[:status_year] = Date.parse(@full_api_data[:legal_status_updated_at]).year
  end

  def designation_type
    @consumer_data[:designation_type] = @full_api_data[:designation][:jurisdiction][:name]
  end
end
