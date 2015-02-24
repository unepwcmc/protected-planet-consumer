require 'test_helper'

class Gef::PameRecordTest < ActiveSupport::TestCase

  test 'data_list retrieves list with all data' do
    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Killbear')

    wdpa_area = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area, wdpa_id: 333444, gef_pame_name: gef_name)

    budget_type = FactoryGirl.create(:gef_budget_type, name: 'Given')

    FactoryGirl.create(:gef_pame_record, gef_wdpa_record: wdpa_area, mett_original_uid: 999888, gef_area: gef_area,
                        gef_pame_name: gef_name, assessment_year: 2007, budget_project_type_id: budget_type.id,
                        budget_recurrent_type_id: budget_type.id)

    result = { gef_pmis_id: 666777, name: 'Killbear', wdpa_id: 333444, assessment_year: 2007,
                budget_project_type: 'Given', budget_recurrent_type: 'Given', mett_original_uid: 999888,
                assessment_year: 2007 }

    assert_equal result, Gef::PameRecord.data_list(mett_original_uid: 999888, wdpa_id: 333444)
  end
end
