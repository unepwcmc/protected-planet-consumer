require 'open-uri'

class ProtectedPlanetReader
  def initialize
    @pp_api_url = Rails.application.secrets.protected_planet_api_url
  end

  def protected_area_from_wdpaid(id: id)
    url = url_generator(fieldname: 'wdpa_id', value: id)
    protected_area_json = open(url).read
    JSON.parse(protected_area_json, symbolize_names: true)
  end

  private

  def url_generator(fieldname: fieldname, value: value)
    "#{@pp_api_url}protected_areas?#{fieldname}=#{value}"
  end
end