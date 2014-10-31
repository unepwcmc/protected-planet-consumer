require 'test_helper'

class Gef::ProtectedAreaControllerTest < ActionController::TestCase
  test '.index returns a 200 HTTP code' do
    FactoryGirl.create(:gef_protected_area, gef_pmis_id: 1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    api_data_mock = mock

    api_data_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, name: 'Willbear')
    Gef::Consumer.expects(:new).times(1).returns(api_data_mock)

    get :index, gef_pmis_id: 1

    assert_response :success
  end
end
