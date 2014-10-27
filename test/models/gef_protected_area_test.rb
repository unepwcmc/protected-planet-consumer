require 'test_helper'

class GefProtectedAreaTest < ActiveSupport::TestCase
  test '.full_data returns a hash with all the data requested' do

    FactoryGirl.create(:gef_protected_area, pa_name_mett: 'Mankind Boneless', gef_pmis_id: 8888)

    consumer_mock = mock
    consumer_mock.expects(:api_data).returns(id: 1, wdpa_id: 555999,  pa_name_wdpa: 'Manbone')

    Gef::Consumer.expects(:new).returns(consumer_mock)

    result = {
      wdpa_id: 555999,
      pa_name_wdpa: 'Manbone',
      pa_name_mett: 'Mankind Boneless',
      gef_pmis_id: 8888
    }

    assert_equal result, GefProtectedArea.where(id: 1).generate_data
  end
end
