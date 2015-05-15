require 'open-uri'

class ProtectedPlanetReader
  class ProtectedAreaRetrievalError < StandardError; end;

  def self.protected_area_from_wdpaid wdpa_id
    instance = new
    instance.protected_area_from_wdpaid wdpa_id
  end

  def initialize
    @pp_api_url = Rails.application.secrets.protected_planet_api_url
  end

  def protected_area_from_wdpaid wdpa_id
    # Backward compatibility for gef
    wdpa_id = wdpa_id[:id] if wdpa_id.is_a? Hash

    url = url_generator(value: wdpa_id)
    protected_area_json = open(url).read
    JSON.parse(protected_area_json, symbolize_names: true) if protected_area_json
  rescue OpenURI::HTTPError
    raise ProtectedAreaRetrievalError, "Can't retrieve Protected Area with wdpa_id #{wdpa_id}"
  end

  private

  def url_generator(value: value)
    @pp_api_url + value.to_s
  end
end
