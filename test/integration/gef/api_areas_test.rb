require 'test_helper'

class Gef::ApiAreasTest < ActionDispatch::IntegrationTest
  test 'returns protected areas for a given gef_id' do

    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    wdpa_area = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area, wdpa_id: 333444)

    FactoryGirl.create(:gef_pame_record, gef_area: gef_area, gef_wdpa_record: wdpa_area, mett_original_uid: 999888)

    get '/gef/api/area?id=666777'

    assert response.success?
    
    areas = JSON.parse(response.body, symbolize_names: true)
    gef_pmis_id = areas.collect{ |z| z[:gef_pmis_id]}
    assert_includes gef_pmis_id, 666777

  end
end