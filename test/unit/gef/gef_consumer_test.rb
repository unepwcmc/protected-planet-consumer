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

    region_mock = mock
    region_mock.expects(:first).returns(id: 111111)
    Gef::Region.expects(:find_or_create_by).with(name: "North Manmerica")
    Gef::Region.expects(:where).with(name:  "North Manmerica").returns(region_mock)
    
    country_mock = mock
    country_mock.expects(:first).returns(id: 222222)
    Gef::Country.expects(:find_or_create_by).with(name: "Manboneland", iso_3: 'MBN', gef_region_id: 111111)
    Gef::Country.expects(:where).with(iso_3:  "MBN").returns(country_mock)
    
    wdpa_each_mock = mock
    wdpa_each_mock.stubs(:id).returns(333333)
    wdpa_mock.expects(:each).yields(wdpa_each_mock)

    Gef::CountryWdpaRecord.expects(:find_or_create_by).with(gef_country_id: 222222, gef_wdpa_record_id: 333333)

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

    region_mock = mock
    region_mock.expects(:first).returns(id: 111111).twice
    Gef::Region.expects(:find_or_create_by).with(name: "North Manmerica").twice
    Gef::Region.expects(:where).with(name:  "North Manmerica").returns(region_mock).twice

    country_mock = mock
    country_mock.expects(:first).returns(id: 222222)
    country_mock_2 = mock
    country_mock_2.expects(:first).returns(id: 444444)

    Gef::Country.expects(:find_or_create_by).with(name: "Manboneland", iso_3: 'MBN', gef_region_id: 111111)
    Gef::Country.expects(:find_or_create_by).with(name: "Killbearbourg", iso_3: "KBR", gef_region_id: 111111)

    Gef::Country.expects(:where).with(iso_3:  "MBN").returns(country_mock)
    Gef::Country.expects(:where).with(iso_3:  "KBR").returns(country_mock_2)

    wdpa_each_mock = mock
    wdpa_each_mock.stubs(:id).returns(333333).twice
    wdpa_mock.expects(:each).yields(wdpa_each_mock).twice

    Gef::CountryWdpaRecord.expects(:find_or_create_by).with(gef_country_id: 222222, gef_wdpa_record_id: 333333)
    Gef::CountryWdpaRecord.expects(:find_or_create_by).with(gef_country_id: 444444, gef_wdpa_record_id: 333333)

    assert_equal true, reader.api_data(wdpa_id: 555999)
  end
end
