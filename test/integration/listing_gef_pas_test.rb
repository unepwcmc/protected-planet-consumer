require 'test_helper'

class ListingGefPasTest < ActionDispatch::IntegrationTest

  test 'returns gef pas filtered by gef_pmis_id' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)
    gef_area_2 = FactoryGirl.create(:gef_area, gef_pmis_id: 2)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 1)
    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_2, pa_name_mett: 'Geres', wdpa_id: 2)
    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Manbone', wdpa_id: 3)

   api_data_mock = mock

   api_data_mock.expects(:api_data).with(wdpa_id: 1).returns(wdpa_id: 1)
   api_data_mock.expects(:api_data).with(wdpa_id: 3).returns(wdpa_id: 3)

   Gef::Consumer.expects(:new).times(2).returns(api_data_mock)

    get 'api/gef/1'

puts response.body

    assert_equal 200, response.status



    gef_pas = JSON.parse(response.body, symbolize_names: true)
    names = gef_pas.map { |pa| pa[:pa_name_mett] }

    assert_includes names, 'Killbear'
    assert_includes names, 'Manbone'
    refute_includes names, 'Geres'
  end
end