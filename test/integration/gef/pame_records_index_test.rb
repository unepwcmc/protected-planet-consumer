require 'test_helper'

class Gef::PameRecordsIndexTest < ActionDispatch::IntegrationTest
  test 'returns a page for given gef_id and wdpa_id' do

    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    wdpa_area = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area, wdpa_id: 333444)

    FactoryGirl.create(:gef_pame_record, gef_wdpa_record: wdpa_area, mett_original_uid: 999888)

    get '/gef/area/666777/wdpa-record/333444/pame-record'

    assert_equal 200, response.status

  end

  test 'returns a list of pame ids for a given gef_id' do

    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    wdpa_area = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area, wdpa_id: 333444)

    FactoryGirl.create(:gef_pame_record, gef_area: gef_area, gef_wdpa_record: wdpa_area, mett_original_uid: 999888)

    FactoryGirl.create(:gef_pame_record, gef_area: gef_area, gef_wdpa_record: wdpa_area, mett_original_uid: 888999)

    get '/gef/area/666777/wdpa-record/333444/pame-record'

    assert_match /999888/, @response.body
    assert_match /888999/, @response.body

  end

  test 'has links to pame show page' do
    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    wdpa_area = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area, wdpa_id: 333444)

    FactoryGirl.create(:gef_pame_record, gef_area: gef_area, gef_wdpa_record: wdpa_area, mett_original_uid: 999888)

    visit '/gef/area/666777/wdpa-record/333444/pame-record'

    assert page.has_link?('999888', /999888/)

  end
end
