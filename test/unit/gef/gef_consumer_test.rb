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
        wdpa_name: 'Manbone',
        original_name: "Manboné",
        marine: true,
        reported_area: 20,
        sub_location: "Manboneland City",
        designation: 'International',
        iucn_category: 'IA',
        designation: 'National',
        jurisdiction: 'International',
        legal_status: 'Proposed',
        governance: "Bone Man",
        wdpa_exists: true
      }


    ProtectedPlanetReader.expects(:new).returns(pp_hash)

    reader = Gef::Consumer.new

    wdpa_mock = mock

    Gef::WdpaRecord.expects(:find_by).with(wdpa_id: 555999).returns(wdpa_mock)

    wdpa_mock.expects(:update).with(result)

    assert_equal true, reader.api_data(wdpa_id: 555999)
  end

  test '.data returns a hash with protected planet data for 2 countries pa' do

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
        },
        {
          :name => "Killbearbourg",
          :iso_3 => "KBR",
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
        wdpa_name: 'Manbone',
        original_name: "Manboné",
        marine: true,
        reported_area: 20,
        sub_location: "Manboneland City",
        designation: 'International',
        iucn_category: 'IA',
        designation: 'National',
        jurisdiction: 'International',
        legal_status: 'Proposed',
        governance: "Bone Man",
        wdpa_exists: true
      }


    ProtectedPlanetReader.expects(:new).returns(pp_hash)

    reader = Gef::Consumer.new

    wdpa_mock = mock

    Gef::WdpaRecord.expects(:find_by).with(wdpa_id: 555999).returns(wdpa_mock)

    wdpa_mock.expects(:update).with(result)

    assert_equal true, reader.api_data(wdpa_id: 555999)
  end
end
