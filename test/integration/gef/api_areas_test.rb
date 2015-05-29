require 'test_helper'

class Gef::ApiAreasTest < ActionDispatch::IntegrationTest

  def setup
    @gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 888999)

    @gef_region_1 = FactoryGirl.create(:gef_region, name: 'Manarctica')

    @gef_country_1 = FactoryGirl.create(:gef_country, name: 'Manboneland', iso_3: 'MBN', gef_region: @gef_region_1)

    @gef_name_1 = FactoryGirl.create(:gef_pame_name, name: 'Manbone')

    @wdpa_record_1 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999888, wdpa_name: 'Manbonal', wdpa_exists: true,
                                        legal_status: 'legal')

    FactoryGirl.create(:gef_country_wdpa_record, gef_wdpa_record: @wdpa_record_1,
                        gef_country: @gef_country_1)

    gef_budget_type_1 = FactoryGirl.create(:gef_budget_type, name: 'Given')

    gef_budget_type_2 = FactoryGirl.create(:gef_budget_type, name: 'Not Given')

    @gef_biome_1 = FactoryGirl.create(:gef_biome, name: 'Manbone Biome')

    @pame_record_1 = FactoryGirl.create(:gef_pame_record,
                        gef_area: @gef_area_1, gef_pame_name: @gef_name_1,
                        primary_biome_id: @gef_biome_1.id, mett_original_uid: 222333,
                        budget_recurrent_type: gef_budget_type_1, budget_project_type: gef_budget_type_2)


    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: @wdpa_record_1,
                        gef_pame_record: @pame_record_1)

    gef_area_2 = FactoryGirl.create(:gef_area, gef_pmis_id: 999888)

    gef_region_2 = FactoryGirl.create(:gef_region, name: 'Womanarctica')

    gef_country_2 = FactoryGirl.create(:gef_country, name: 'Bonewomanland', iso_3: 'BWL', gef_region: @gef_region_1)

    gef_name_2 = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    wdpa_record_2 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999888,
                                        wdpa_name: 'Womanbonal', wdpa_exists: true)

    FactoryGirl.create(:gef_country_wdpa_record, gef_wdpa_record: wdpa_record_2,
                        gef_country: gef_country_2)

    gef_biome_2 = FactoryGirl.create(:gef_biome, name: 'Womanbone Biome')

    pame_record_2 = FactoryGirl.create(:gef_pame_record,
                        gef_area: gef_area_2, gef_pame_name: gef_name_2,
                        primary_biome_id: gef_biome_2.id,
                        budget_recurrent_type: gef_budget_type_1, budget_project_type: gef_budget_type_2)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record_2,
                         gef_pame_record: pame_record_2)
  end

  test 'returns protected areas for gef pmis id' do

    get '/gef/api/areas?gef_pmis_id=888999'

    assert response.success?

    areas = JSON.parse(response.body, symbolize_names: true)

    legal_status = areas[0][:legal_status]

    assert_equal legal_status, 'legal'

    assert_equal areas.length, 1

  end

  test 'returns protected areas for country' do

    get '/gef/api/areas?iso3=MBN'

    assert response.success?

    areas = JSON.parse(response.body, symbolize_names: true)

    legal_status = areas[0][:legal_status]

    assert_equal legal_status, 'legal'

    assert_equal areas.length, 1

  end

  test 'returns protected areas for all attributes' do

    get '/gef/api/areas?gef_pmis_id=888999&primary_biome=Manbone+Biome&iso3=MBN&region=Manarctica&wdpa_id=999888'

    assert response.success?

    areas = JSON.parse(response.body, symbolize_names: true)

    legal_status = areas[0][:legal_status]

    assert_equal legal_status, 'legal'

    assert_equal areas.length, 1

  end
end