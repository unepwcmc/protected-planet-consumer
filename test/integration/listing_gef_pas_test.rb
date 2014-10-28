require 'test_helper'

class ListingGefPasTest < ActionDispatch::IntegrationTest
  test 'returns a list of all gef pas' do
    get '/api/gef'
    assert_response 200, response.status
  end

  test 'returns gef pas filtered by gef_pmis_id' do
    FactoryGirl.create(:gef_protected_area, gef_pmis_id: 1, pa_name_mett: 'Killbear')
    FactoryGirl.create(:gef_protected_area, gef_pmis_id: 2, pa_name_mett: 'Geres')

    get 'api/gef?pmis_id=1'
    assert_equal 200, response.status

    gef_pas = JSON.parse(response.body, symbolize_names: true)
    names = gef_pas.map { |pa| pa[:pa_name_mett] }
    assert_includes names, 'Killbear'
    refute_includes names, 'Geres'
  end
end