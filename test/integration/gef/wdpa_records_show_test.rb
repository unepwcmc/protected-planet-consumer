require 'test_helper'

def setup
  gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

  FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)
end

class Gef::WdpaRecordsShowTest < ActionDispatch::IntegrationTest
  test 'returns a page for given gef_id and wdpa_id' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock

    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    get '/gef/area/666777/wdpa_record/999888'

    assert_equal 200, response.status
  end

  test 'renders WDPA heading' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock

    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    visit '/gef/area/666777/wdpa_record/999888'

    assert page.has_selector?('h2', text: '999888 - Willbear'), 'h2 does not match'
  end

  test 'renders pa_name_mett in attributes table' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock

    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear', })

    Gef::Consumer.expects(:new).returns(consumer_mock)

    visit '/gef/area/666777/wdpa_record/999888'

    assert page.has_selector?('table', text: /Killbear/), 'pa_name_mett not in table'
  end

  test 'renders wdpa_name in attributes table' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock

    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear', })

    Gef::Consumer.expects(:new).returns(consumer_mock)

    visit '/gef/area/666777/wdpa_record/999888'

    assert page.has_selector?('table', text: /Willbear/), 'WDPA_NAME not in table'
  end
end
