class Gef::Consumer

  DIRECT_VALUES = [:reported_area, :original_name, :marine]
  WITH_NAME = [:designation, :iucn_category, :governance, :legal_status]

  def api_data wdpa_id: wdpa_id
    reader = ProtectedPlanetReader.new
    @consumer_data = {}
    # avoids constant calls for 999999999
    if wdpa_id == 999999999
      @consumer_data[:wdpa_exists] = false
    else
      @full_api_data = reader.protected_area_from_wdpaid(id: wdpa_id) rescue @consumer_data[:wdpa_exists] = false
    end

    if @consumer_data == {}
      @consumer_data[:wdpa_exists] = true
      direct_values && name && jurisdiction && only_name   ##sub_location &&  status_year && countries 
    end

    wdpa_record = Gef::WdpaRecord.where(wdpa_id: wdpa_id)
    wdpa_record.each { |record| record.update(@consumer_data)}

    if @consumer_data[:wdpa_exists] == true
      @full_api_data[:countries].each do |country|
        puts country
        Gef::Region.find_or_create_by(name: country[:region][:name])
        region_id = Gef::Region.where(name: country[:region][:name]).first[:id]

        Gef::Country.find_or_create_by(name: country[:name], iso_3: country[:iso_3], gef_region_id: region_id)
        country_id = Gef::Country.where(iso_3: country[:iso_3]).first[:id]

        wdpa_record.each do |record|
          Gef::CountryWdpaRecord.find_or_create_by(gef_country_id: country_id, gef_wdpa_record_id: record.id)
        end
      end
    end

    return true
  end

  private

  def direct_values
    DIRECT_VALUES.each do |value|
      @consumer_data[value] =  @full_api_data[value] rescue nil
    end
  end

  def only_name
    WITH_NAME.each do |value|
      @consumer_data[value] =  @full_api_data[value][:name] rescue nil
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
    @consumer_data[:wdpa_name] = @full_api_data[:name] rescue nil
  end

  def status_year
    @consumer_data[:status_year] = Date.parse(@full_api_data[:legal_status_updated_at]).year rescue nil
  end

  def jurisdiction
    @consumer_data[:jurisdiction] = @full_api_data[:designation][:jurisdiction][:name] rescue nil
  end

  def sub_location
    @consumer_data[:sub_location] = @full_api_data[:sub_locations][0][:english_name] rescue nil
  end
end
