require 'test_helper'

class Gef::WdpaRecordsShowTest < ActionDispatch::IntegrationTest
  test 'returns a page for given gef_id and wdpa_id' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, pa_name_mett: 'Killbear', wdpa_id: 999888)

    get '/gef/area/1/wdpa_record/999888'

    assert_equal 200, response.status    
  end
end
