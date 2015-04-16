require 'test_helper'

class Gef::SearchNewTest < ActionDispatch::IntegrationTest

  def setup

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 888999)

    gef_region_1 = FactoryGirl.create(:gef_region, name: 'Manarctica')

    gef_country_1 = FactoryGirl.create(:gef_country, name: 'Manboneland', gef_region: gef_region_1)

    gef_name_1 = FactoryGirl.create(:gef_pame_name, name: 'Manbone')

    wdpa_record_1 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999888)

    FactoryGirl.create(:gef_country_wdpa_record, gef_wdpa_record: wdpa_record_1,
                        gef_country: gef_country_1)

    gef_biome_1 = FactoryGirl.create(:gef_biome, name: 'Manbone Biome')

    pame_record_1 = FactoryGirl.create(:gef_pame_record,
                        gef_area: gef_area_1, gef_pame_name: gef_name_1,
                        primary_biome_id: gef_biome_1.id)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record_1,
                        gef_pame_record: pame_record_1)

    gef_area_2 = FactoryGirl.create(:gef_area, gef_pmis_id: 999888)

    gef_region_2 = FactoryGirl.create(:gef_region, name: 'Womanarctica')

    gef_country_2 = FactoryGirl.create(:gef_country, name: 'Bonewomanland', gef_region: gef_region_1)

    gef_name_2 = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    wdpa_record_2 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999888)

    FactoryGirl.create(:gef_country_wdpa_record, gef_wdpa_record: wdpa_record_2,
                        gef_country: gef_country_2)

    gef_biome_2 = FactoryGirl.create(:gef_biome, name: 'Womanbone Biome')

    pame_record_2 = FactoryGirl.create(:gef_pame_record,
                        gef_area: gef_area_2, gef_pame_name: gef_name_2,
                        primary_biome_id: gef_biome_2.id)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record_2,
                         gef_pame_record: pame_record_2)
  end

  test 'dropdowns list all options' do

    visit '/gef/searches/new'

    assert page.has_select?("gef_search_gef_country_id", :options => ['','Bonewomanland', 'Manboneland' ])

    assert page.has_select?("gef_search_gef_region_id", :options => ['','Manarctica', 'Womanarctica' ])

    assert page.has_select?("gef_search_primary_biome_id", :options => ['','Manbone Biome', 'Womanbone Biome' ])
  end

  test 'has all labels' do

    visit '/gef/searches/new'

    assert page.has_selector?('label', text: 'Country')

    assert page.has_selector?('label', text: 'Region')

    assert page.has_selector?('label', text: 'GEF ID')

    assert page.has_selector?('label', text: 'Primary Biome')

    assert page.has_selector?('label', text: 'WDPA Name')

    assert page.has_selector?('label', text: 'WDPA ID')
  end
end
