class TestProtectedPlanetReader < ActiveSupport::TestCase

  def setup
    Rails.application.secrets.protected_planet_api_url = 'http://mywebsite.com/api/protected_areas/'
  end

  test '.wdpa_id returns a hash with the given protected area from ProtectedPlanet API' do

    json_file = File.read(File.join('test', 'fixtures', 'pp_area.json'))

    stub_request(:get,'http://mywebsite.com/api/protected_areas/1').
       to_return(status: 200, body: json_file, :headers => {})

    reader = ProtectedPlanetReader.new()
    protected_area_hash = reader.protected_area_from_wdpaid(id: 1)

    assert_equal 'Killbear', protected_area_hash[:name]
  end
end