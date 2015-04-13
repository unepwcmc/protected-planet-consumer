require 'test_helper'

class Gef::SearchTest < ActiveSupport::TestCase
  test 'search gets correct data for 2 pame records in same area' do
    gef_area = FactoryGirl.create(:gef_area, gef_pmis_id: 666777)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Killbear')

    wdpa_record = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 333444)

    gef_biome = FactoryGirl.create(:gef_biome, name: 'Manbone Biome')

    gef_pame_record_1 = FactoryGirl.create(:gef_pame_record,
                        gef_area: gef_area, gef_pame_name: gef_name,
                        primary_biome_id: gef_biome.id, mett_original_uid: 222333)

    gef_pame_record_2 = FactoryGirl.create(:gef_pame_record,
                        gef_area: gef_area, gef_pame_name: gef_name,
                        primary_biome_id: gef_biome.id, mett_original_uid: 333222)


    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record, 
                        gef_pame_record: gef_pame_record_1)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record, 
                        gef_pame_record: gef_pame_record_2)

    search = FactoryGirl.create(:gef_search, id: 1, gef_pmis_id: nil, primary_biome: 'Manbone Biome')

    result =
            [
              [:wdpa_id, :gef_pmis_id, :mett_original_uid, :primary_biome ],
              ['333444', 666777, 222333, 'Manbone Biome' ]
            ]


    test = Gef::Search.find(1).to_csv

    assert_equal result.length, Gef::Search.find(1).to_csv.length
  end
end
