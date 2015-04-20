require 'test_helper'

class Gef::PameRecordsIndexTest < ActionDispatch::IntegrationTest
  test 'returns a page for given gef_id and wdpa_id' do

    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    wdpa_record = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 333444)

    gef_pame_record = FactoryGirl.create(:gef_pame_record, gef_area: gef_area, mett_original_uid: 999888)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record, 
                        gef_pame_record: gef_pame_record)

    get '/gef/areas/666777/wdpa_records/333444/pame_records'

    assert_equal 200, response.status

  end

  test 'returns a list of pame ids for a given gef_id' do

    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    wdpa_record = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 333444)

    gef_pame_record_1 = FactoryGirl.create(:gef_pame_record, gef_area: gef_area, mett_original_uid: 999888)

    gef_pame_record_2 = FactoryGirl.create(:gef_pame_record, gef_area: gef_area, mett_original_uid: 888999)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record, 
                        gef_pame_record: gef_pame_record_1)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record, 
                        gef_pame_record: gef_pame_record_2)

    get '/gef/areas/666777/wdpa_records/333444/pame_records'

    assert_match /999888/, @response.body
    assert_match /888999/, @response.body

  end

  test 'has links to pame show page' do
    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    wdpa_record = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 333444)

    gef_pame_record = FactoryGirl.create(:gef_pame_record, gef_area: gef_area, mett_original_uid: 999888)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record, 
                        gef_pame_record: gef_pame_record)

    visit '/gef/areas/666777/wdpa_records/333444/pame_records'

    assert page.has_link?('999888', /999888/)

  end
end
