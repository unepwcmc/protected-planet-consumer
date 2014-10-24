class TestGefConsumer < ActiveSupport::TestCase

  test '.data returns a hash with protected planet data' do 

    time = Time.local(2008, 9, 1, 10, 5, 0)

    pp_data = {
      :wdpa_id => 555999,
      :name => 'Manbone',
      :original_name => "Manboné",
      :marine => true,
      :legal_status_updated_at => time,
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
      with(:wdpa_id).
      returns(pp_data)

    result = {
      wdpa_pa_name: 'Manbone',
      designation: 'National',
      designation_type: 'International',
      iucn_category: 'IA',
      governance: 'Bone Man',
      reported_area: 20,
      status: 'Proposed',
      status_year: 2008,
      iso_3: 'MBN',
      region: 'North Manmerica'
    }

    ProtectedPlanetReader.expects(:new).returns(pp_hash)

    reader = Gef::Consumer.new()

    assert_equal result, reader.data
  end
end