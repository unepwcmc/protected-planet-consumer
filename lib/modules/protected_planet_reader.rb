require 'open-uri'

class ProtectedPlanetReader
  def initialize
    @pp_api_url = Rails.application.secrets.protected_planet_api_url
  end

  def protected_area_from_wdpaid(id: id)
    url = url_generator(value: id)
    protected_area_json = open(url).read
    JSON.parse(protected_area_json, symbolize_names: true) if protected_area_json
  end

  private

  def url_generator(value: value)
    @pp_api_url + value.to_s
  end
end
