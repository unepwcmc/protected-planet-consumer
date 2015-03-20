require 'test_helper'

class Gef::SearchNewTest < ActionDispatch::IntegrationTest

  def setup

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 888999)

    gef_region_1 = FactoryGirl.create(:gef_region, name: 'Manarctica')

    gef_country_1 = FactoryGirl.create(:gef_country, name: 'Manboneland', gef_region: gef_region_1)

    gef_name_1 = FactoryGirl.create(:gef_pame_name, name: 'Manbone')

    wdpa_record_1 = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, 
                                      gef_pame_name: gef_name_1, wdpa_id: 999888)

    FactoryGirl.create(:gef_pame_record, gef_wdpa_record: wdpa_record_1, 
                        gef_area: gef_area_1, gef_pame_name: gef_name_1, 
                        primary_biome: 'Manbone Biome')

    gef_area_2 = FactoryGirl.create(:gef_area, gef_pmis_id: 999888)

    gef_region_2 = FactoryGirl.create(:gef_region, name: 'Womanarctica')

    gef_country_2 = FactoryGirl.create(:gef_country, name: 'Bonewomanland', gef_region: gef_region_1)

    gef_name_2 = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    wdpa_record_2 = FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, 
                                      gef_pame_name: gef_name_2, wdpa_id: 999888)

    FactoryGirl.create(:gef_pame_record, gef_wdpa_record: wdpa_record_2, 
                        gef_area: gef_area_2, gef_pame_name: gef_name_2, 
                        primary_biome: 'Womanbone Biome')
  end

  test 'dropdowns list all options' do
    visit '/gef/searches/new'

    assert page.has_select?("gef_search_gef_country_id", :options => ['','Bonewomanland', 'Manboneland' ])

    assert page.has_select?("gef_search_gef_region_id", :options => ['','Manarctica', 'Womanarctica' ])

    assert page.has_select?("gef_search_primary_biome", :options => ['','Manbone Biome', 'Womanbone Biome' ])
  end


end