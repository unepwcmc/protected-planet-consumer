class TestProtectedPlanetReader < ActiveSupport::TestCase

  def setup
    Rails.application.secrets.protected_planet_api_url = 'http://my_website.com/api/'
  end

  test '.wdpa_id returns a hash with the given protected area from ProtectedPlanet API' do

    json_file = File.read(File.join('test','fixtures','pp_area.json'))

    stub_request(:get,'http://my_website.com/api/protected_areas?wdpa_id=1').
      to_return(status: 200, body: json_file)

    reader = ProtectedPlanetReader.new()
    protected_area_hash = reader.wdpaid(id: 1)
  
    assert_equal 'Manbone', protected_area_hash[:name]
  
  end
end