require 'test_helper'

class Gef::WdpaRecordsIndexTest < ActionDispatch::IntegrationTest
  test 'returns list of gef pas for given gef_pmis_id' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    get '/gef/area/1/wdpa_record'

    assert_equal 200, response.status
  end

  test 'renders GEF Heading' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    visit '/gef/area/1/wdpa_record'
    
    assert page.has_selector?('h2', text: 'GEF ID #1'), 'h2 does not match'
  end

  test 'renders WDPA name' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    get '/gef/area/1/wdpa_record'

    assert_match /Willbear/, @response.body
  end

  test 'renders WDPA ID' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    get '/gef/area/1/wdpa_record'

    assert_match /999888/, @response.body
  end

  test 'renders Protected Planet Link' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    get '/gef/area/1/wdpa_record'

    assert page.has_link?('Link', :href => 'http://alpha.protectedplanet.net/999888'),
      'Has no 999888 PP.net link'
  end

  test 'has links to wdpa_page' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    consumer_mock = mock
    consumer_mock.expects(:api_data).with(wdpa_id: 999888).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Willbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    Gef::Consumer.expects(:new).returns(consumer_mock)

    visit '/gef/area/1/wdpa_record'

    assert page.has_link?('Willbear', /999888/)

  end

end
