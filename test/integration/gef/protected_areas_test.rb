require 'test_helper'

class Gef::ProtectedAreasTest < ActionDispatch::IntegrationTest
  test 'returns list of gef pas for given gef_pmis_id' do
    FactoryGirl.create(:gef_protected_area, gef_pmis_id: 1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    Gef::ProtectedArea.stubs(:generate_data).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    get '/gef/1'
    assert_equal 200, response.status
  end

  test 'renders GEF Heading' do
    FactoryGirl.create(:gef_protected_area, gef_pmis_id: 1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    Gef::ProtectedArea.stubs(:generate_data).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    get '/gef/1'

    assert page.has_selector?('h1', text: 'GEF ID: #1'), 'h1 does not match'
  end

  test 'renders WDPA name' do
FactoryGirl.create(:gef_protected_area, gef_pmis_id: 1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    Gef::ProtectedArea.stubs(:generate_data).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    get 'gef/1'

    assert_match /Willbear/, @response.body
  end

  test 'renders WDPA ID' do
    FactoryGirl.create(:gef_protected_area, gef_pmis_id: 1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    Gef::ProtectedArea.stubs(:generate_data).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    get '/gef/1'

    assert_match /999888/, @response.body
  end

  test 'renders Protected Planet Link' do
    FactoryGirl.create(:gef_protected_area, gef_pmis_id: 1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    Gef::ProtectedArea.stubs(:generate_data).returns(wdpa_id: 1, gef_pmis_id: 1, name: 'Killbear', wdpa_id: 999888, wdpa_data: {name: 'Willbear'})

    visit '/gef/1'

    assert page.has_link?('ProtectedPlanet.net', :href => 'http://alpha.protectedplanet.net/999888'),
      'Has no 999888 PP.net link'
  end
end
