require 'test_helper'

class Gef::ApiAreasTest < ActionDispatch::IntegrationTest

  test 'returns protected areas for gef pmis id' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 888999)

    gef_region_1 = FactoryGirl.create(:gef_region, name: 'Manarctica')

    gef_country_1 = FactoryGirl.create(:gef_country, name: 'Manboneland', gef_region: gef_region_1)

    gef_name_1 = FactoryGirl.create(:gef_pame_name, name: 'Manbone')

    wdpa_record_1 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999888, legal_status: 'legal')

    gef_biome = FactoryGirl.create(:gef_biome, name: 'Manbone Biome')

    gef_budget_type_1 = FactoryGirl.create(:gef_budget_type, name: 'Given')

    gef_budget_type_2 = FactoryGirl.create(:gef_budget_type, name: 'Not Given')

    gef_pame_record_1 = FactoryGirl.create(:gef_pame_record, gef_area: gef_area_1, 
                        gef_pame_name: gef_name_1, primary_biome_id: gef_biome.id,
                        budget_recurrent_type: gef_budget_type_1, budget_project_type: gef_budget_type_2)


    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record_1,
                        gef_pame_record: gef_pame_record_1)

    get '/gef/api/areas?gef_pmis_id=888999'

    assert response.success?

    areas = JSON.parse(response.body, symbolize_names: true)

    legal_status = areas[0][:legal_status]

    assert_equal legal_status, 'legal'

  end

  test 'returns protected areas for all attributes' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 888999)

    gef_region_1 = FactoryGirl.create(:gef_region, name: 'Manarctica')

    gef_country_1 = FactoryGirl.create(:gef_country, name: 'Manboneland', gef_region: gef_region_1)

    gef_name_1 = FactoryGirl.create(:gef_pame_name, name: 'Manbone')

    wdpa_record_1 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999888, legal_status: 'legal')

    gef_biome = FactoryGirl.create(:gef_biome, name: 'Manbone Biome')

    gef_budget_type_1 = FactoryGirl.create(:gef_budget_type, name: 'Given')

    gef_budget_type_2 = FactoryGirl.create(:gef_budget_type, name: 'Not Given')

    gef_pame_record_1 = FactoryGirl.create(:gef_pame_record, gef_area: gef_area_1,
                        gef_pame_name: gef_name_1, primary_biome_id: gef_biome.id,
                        budget_recurrent_type: gef_budget_type_1, budget_project_type: gef_budget_type_2)


    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record_1,
                        gef_pame_record: gef_pame_record_1)

    get '/gef/api/areas?gef_pmis_id=888999&primary_biome=Biome&country=Manboneland&region=Manarctica&wdpa_id=999888'

    assert response.success?
    
    areas = JSON.parse(response.body, symbolize_names: true)

    legal_status = areas[0][:legal_status]

    assert_equal legal_status, 'legal'

  end
end