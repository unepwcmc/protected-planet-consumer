require 'test_helper'

class Gef::WdpaRecordTest < ActiveSupport::TestCase
  test '.generate_data returns a hash with all the data requested' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 8888)

    FactoryGirl.create(:gef_wdpa_record,
      id: 1,
      wdpa_id: 555999,
      pa_name_mett: 'Mankind Boneless'
      )

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 555999).returns(wdpa_id: 555999,  pa_name_wdpa: 'Manbone')

    Gef::Consumer.expects(:new).returns(consumer_mock)

    result = {
      id: 1,
      wdpa_id: 555999,
      pa_name_mett: 'Mankind Boneless',
      pa_name_wdpa: 'Manbone'
    }

    assert_equal result, Gef::WdpaRecord.where(id: 1).first.generate_data
  end
end
