class TestGefConsumer < ActiveSupport::TestCase

  test '.data returns a hash with protected planet data' do 

    time = Time.local(2008, 9, 1, 10, 5, 0)

    pp_data = {
      :wdpa_id => 555999,
      :name => 'Manbone',
      :original_name => "Manboné",
      :marine => true,
      :legal_status_updated_at => time.to_s,
      :reported_area => 20,
      :sub_locations => [
        {
          :english_name => "Manboneland City"
        }
      ],
      :countries => [
        {
          :name => "Manboneland",
          :iso_3 => "MBN",
          :region => {
            :name => "North Manmerica"
          }
        }
      ],
      :iucn_category => {
        :name => "IA"
      },
      :designation => {
        :name => "National",
        :jurisdiction => {
          :name => "International"
        }
      },
      :legal_status => {
        :name => "Proposed"
      },
      :governance => {
        :name => "Bone Man"
      }
    }

    pp_hash = mock
    pp_hash.expects(:protected_area_from_wdpaid).
      with(id: 555999).
      returns(pp_data)

    result = {
      wdpa_id: 555999,
      wdpa_pa_name: 'Manbone',
      wdpa_designation: 'National',
      wdpa_designation_type: 'International',
      wdpa_iucn_category: 'IA',
      wdpa_governance: 'Bone Man',
      wdpa_reported_area: 20,
      wdpa_status: 'Proposed',
      wdpa_status_year: 2008,
      wdpa_iso_3: 'MBN',
      wdpa_region: 'North Manmerica'
    }

    ProtectedPlanetReader.expects(:new).returns(pp_hash)

    reader = Gef::Consumer.new

    assert_equal result, reader.api_data(wdpa_id: 555999)
  end
end