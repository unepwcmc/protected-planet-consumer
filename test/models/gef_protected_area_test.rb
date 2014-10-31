require 'test_helper'

class GefProtectedAreaTest < ActiveSupport::TestCase
  test '.full_data returns a hash with all the data requested' do

    current_time = Time.now
    FactoryGirl.create(:gef_protected_area,
      id: 1,
      wdpa_id: 555999,
      pa_name_mett: 'Mankind Boneless',
      gef_pmis_id: 8888
      )

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 555999).returns(wdpa_id: 555999,  pa_name_wdpa: 'Manbone')

    Gef::Consumer.expects(:new).returns(consumer_mock)

    result = {
      id: 1,
      gef_pmis_id: '8888',
      wdpa_id: 555999,
      pa_name_mett: 'Mankind Boneless',
      pa_name_wdpa: 'Manbone'
    }

    assert_equal result, Gef::ProtectedArea.where(id: 1).first.generate_data
  end
end
