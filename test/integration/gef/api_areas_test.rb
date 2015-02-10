require 'test_helper'

class Gef::ApiAreasTest < ActionDispatch::IntegrationTest
  test 'returns protected areas for a given gef_id' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)
    wdpa_area_1 = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, wdpa_id: 333444)
    FactoryGirl.create(:gef_pame_record, gef_area: gef_area_1, gef_wdpa_record: wdpa_area_1, mett_original_uid: 999888)

    Gef::WdpaRecord.expects(:wdpa_name)
                   .with(gef_pmis_id: 666777)
                   .returns([{ wdpa_name: 'Willbear', wdpa_id: 333444,
                                protected_planet_url: "http://alpha.protectedplanet.net/333444" }])

    get '/gef/api/area?id=666777'

    assert response.success?
    
    areas = JSON.parse(response.body, symbolize_names: true)

    gef_pmis_id = areas[0][:gef_pmis_id]
    wdpa_id = areas[0][:wdpa_id]
    mett_original_uid = areas[0][:assessments][0][:mett_original_uid]

    assert_equal gef_pmis_id, 666777
    assert_equal wdpa_id, 333444
    assert_equal mett_original_uid, 999888

  end
end