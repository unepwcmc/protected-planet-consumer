require 'test_helper'

class Gef::AreaTest < ActiveSupport::TestCase
  test '.generate_data returns a hash with all the data requested' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 8888)

    FactoryGirl.create(:gef_wdpa_record,
        id: 1,
        wdpa_id: 555999
      )

    Gef::WdpaRecord.expects(:wdpa_name).with(gef_pmis_id: 8888).returns([wdpa_id: 555999, wdpa_name: 'Manbone'])

    result = [{
      gef_pmis_id: 8888,
      wdpa_id: 555999,
      wdpa_name: 'Manbone'
    }]

    assert_equal result, Gef::Area.where(gef_pmis_id: 8888).first.generate_data
  end
end
