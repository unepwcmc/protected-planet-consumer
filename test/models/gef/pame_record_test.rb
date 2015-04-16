require 'test_helper'

class Gef::PameRecordTest < ActiveSupport::TestCase

  test 'data_list retrieves list with all data' do
    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Killbear')

    wdpa_area = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 333444)

    budget_type = FactoryGirl.create(:gef_budget_type, name: 'Given')

    pame_record = FactoryGirl.create(:gef_pame_record, mett_original_uid: 999888, gef_area: gef_area,
                        gef_pame_name: gef_name, assessment_year: 2007, budget_project_type_id: budget_type.id,
                        budget_recurrent_type_id: budget_type.id)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_area, gef_pame_record: pame_record)




    result = { gef_pmis_id: 666777, name: 'Killbear', wdpa_id: 333444, assessment_year: 2007,
                budget_recurrent_type: 'Given', mett_original_uid: 999888,
                assessment_year: 2007 }

    assert_equal result[:budget_recurrent_type], Gef::PameRecord.data_list(mett_original_uid: 999888, wdpa_id: 333444)[:budget_recurrent_type]
    assert_equal result[:assessment_year], Gef::PameRecord.data_list(mett_original_uid: 999888, wdpa_id: 333444)[:assessment_year]
    assert_equal result[:gef_pmis_id], Gef::PameRecord.data_list(mett_original_uid: 999888, wdpa_id: 333444)[:gef_pmis_id]
  end
end
