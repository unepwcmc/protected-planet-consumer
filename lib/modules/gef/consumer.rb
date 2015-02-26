class Gef::Consumer

  DIRECT_VALUES = [:reported_area, :original_name, :marine]
  WITH_NAME = [:designation, :iucn_category, :governance, :legal_status]

  def api_data wdpa_id: wdpa_id
    reader = ProtectedPlanetReader.new
    @consumer_data = {}
    @full_api_data = reader.protected_area_from_wdpaid(id: wdpa_id) rescue @consumer_data[:wdpa_exists] = false

    if @consumer_data == {}
      @consumer_data[:wdpa_exists] = true
      direct_values && name && jurisdiction && sub_location && only_name   #&& status_year && countries
    end

    wdpa_record = Gef::WdpaRecord.find_by(wdpa_id: wdpa_id)

    wdpa_record.update(@consumer_data)

    return true
  end

  private

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

  def name
    @consumer_data[:wdpa_name] = @full_api_data[:name]
  end

  def status_year
    @consumer_data[:status_year] = Date.parse(@full_api_data[:legal_status_updated_at]).year rescue nil
  end

  def jurisdiction
    @consumer_data[:jurisdiction] = @full_api_data[:designation][:jurisdiction][:name]
  end

  def sub_location
    @consumer_data[:sub_location] = @full_api_data[:sub_locations][0][:english_name]
  end
end
