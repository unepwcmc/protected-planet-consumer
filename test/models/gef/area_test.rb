require 'test_helper'

class Gef::AreaTest < ActiveSupport::TestCase
  test '.generate_data returns a hash with all the data requested' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 8888)

    FactoryGirl.create(:gef_wdpa_record,
        id: 1,
        wdpa_id: 555999
      )

    Gef::WdpaRecord.expects(:wdpa_name)
                   .with(gef_pmis_id: 8888)
                   .returns([wdpa_id: 555999, wdpa_name: 'Manbone',
                             protected_planet_url: 'http://alpha.protectedplanet.net/555999'])

    result = [{
      gef_pmis_id: 8888,
      wdpa_id: 555999,
      wdpa_name: 'Manbone',
      protected_planet_url: 'http://alpha.protectedplanet.net/555999'
    }]

    assert_equal result, Gef::Area.where(gef_pmis_id: 8888).first.generate_data
  end

  test 'generate_api_data returns a hash with all the data requested' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 8888)
    wdpa_area_1 = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, wdpa_id: 333444)
    FactoryGirl.create(:gef_pame_record, gef_area: gef_area_1, gef_wdpa_record: wdpa_area_1,
                        mett_original_uid: 888999, assessment_year: 2003)
    FactoryGirl.create(:gef_pame_record, gef_area: gef_area_1, gef_wdpa_record: wdpa_area_1,
                        mett_original_uid: 999888, assessment_year: 2005)

    Gef::WdpaRecord.expects(:wdpa_name)
                   .with(gef_pmis_id: 8888)
                   .returns([wdpa_id: 333444, wdpa_name: 'Manbone',
                             protected_planet_url: 'http://alpha.protectedplanet.net/555999'])

    result = [{
      wdpa_id: 333444,
      wdpa_name: 'Manbone',
      protected_planet_url: 'http://alpha.protectedplanet.net/555999',
      gef_pmis_id: 8888,
      assessments: [{ mett_original_uid: 888999, assessment_year: "2003" },
                    { mett_original_uid: 999888, assessment_year: "2005" }]
      }]

    assert_equal result, Gef::Area.where(gef_pmis_id: 8888).first.generate_api_data
  end

  test '.to_csv returns all csv data' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 8888)
    wdpa_area_1 = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, wdpa_id: 333444)
    FactoryGirl.create(:gef_pame_record, gef_area: gef_area_1, gef_wdpa_record: wdpa_area_1,
                        mett_original_uid: 888999, assessment_year: 2003)


    Gef::WdpaRecord.expects(:wdpa_name)
                   .with(gef_pmis_id: 8888)
                   .returns([wdpa_id: 333444, wdpa_name: 'Manbone',
                             protected_planet_url: 'http://alpha.protectedplanet.net/555999'])

    result = [[:wdpa_name],['Manbone']]

    request =  Gef::Area.where(gef_pmis_id: 8888).first.to_csv
    assert_equal result[0][0], request[0][1]
  end
end
