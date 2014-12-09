require 'test_helper'

class Gef::WdpaRecordTest < ActiveSupport::TestCase
  test '.name returns a hash with all the data requested' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 8888)

    gef_pame_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    FactoryGirl.create(:gef_wdpa_record,
      gef_area: gef_area_1,
      gef_pame_name: gef_pame_name,
      wdpa_id: 555999
      )

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 555999).returns(wdpa_id: 555999,  wdpa_data: {name: 'Manbone'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    result = [{ wdpa_exists: true, wdpa_name: 'Manbone', wdpa_id: 555999, protected_planet_url: 'http://www.protectedplanet.net/sites/555999'}]

    assert_equal result, Gef::WdpaRecord.wdpa_name(gef_pmis_id: 8888)
  end
end
