require 'test_helper'

class Gef::WdpaRecordTest < ActiveSupport::TestCase
  test '.name returns a array with all the data requested and pp url' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 8888)

    gef_pame_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    gef_pame_record = FactoryGirl.create(:gef_pame_record, gef_area: gef_area_1, gef_pame_name: gef_pame_name)

    gef_wdpa_record = FactoryGirl.create(:gef_wdpa_record,
      wdpa_exists: true,
      wdpa_id: 555999,
      original_name: 'Manboné',
      wdpa_name: 'Manbone'
      )

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: gef_wdpa_record, gef_pame_record: gef_pame_record)


    assert_equal 'Manboné', Gef::WdpaRecord.wdpa_name(gef_pmis_id: 8888)[0][:original_name]
    assert_equal 'http://www.protectedplanet.net/sites/555999', Gef::WdpaRecord.wdpa_name(gef_pmis_id: 8888)[0][:protected_planet_url]
    assert_equal 'Manbone',  Gef::WdpaRecord.wdpa_name(gef_pmis_id: 8888)[0][:wdpa_name]
  end
end
