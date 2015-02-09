require 'test_helper'

class Gef::ApiAreasTest < ActionDispatch::IntegrationTest
  test 'returns protected areas for a given gef_id' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)
    wdpa_area_1 = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, wdpa_id: 333444)
    FactoryGirl.create(:gef_pame_record, gef_area: gef_area_1, gef_wdpa_record: wdpa_area_1, mett_original_uid: 999888)

    gef_area_2 = FactoryGirl.create(:gef_area, gef_pmis_id: 888999)
    wdpa_area_2 = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_2, wdpa_id: 111222)
    FactoryGirl.create(:gef_pame_record, gef_area: gef_area_2, gef_wdpa_record: wdpa_area_2, mett_original_uid: 222333)



    Gef::WdpaRecord.expects(:wdpa_name)
                   .with(gef_pmis_id: 666777)
                   .returns([{ wdpa_name: 'Willbear', wdpa_id: 333444,
                                protected_planet_url: "http://alpha.protectedplanet.net/333444" }])

    get '/gef/api/area?id=666777'

    assert response.success?
    
    areas = JSON.parse(response.body, symbolize_names: true)
    gef_pmis_id = areas.collect{ |z| z[:gef_pmis_id]}
    wdpa_id = areas.collect{ |z| z[:wdpa_id]}

    assert_includes gef_pmis_id, 666777
    assert_includes wdpa_id, 333444

    refute_includes gef_pmis_id, 888999

  end
end