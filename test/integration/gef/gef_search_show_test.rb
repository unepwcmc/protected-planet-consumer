class Gef::SearchShowTest < ActionDispatch::IntegrationTest

  def setup


    @gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 888999)

    @gef_region_1 = FactoryGirl.create(:gef_region, name: 'Manarctica')

    @gef_country_1 = FactoryGirl.create(:gef_country, name: 'Manboneland', gef_region: @gef_region_1)

    @gef_name_1 = FactoryGirl.create(:gef_pame_name, name: 'Manbone')

    @wdpa_record_1 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999888, wdpa_name: 'Manbonal', wdpa_exists: true)

    FactoryGirl.create(:gef_country_wdpa_record, gef_wdpa_record: @wdpa_record_1,
                        gef_country: @gef_country_1)

    @gef_biome_1 = FactoryGirl.create(:gef_biome, name: 'Manbone Biome')

    @pame_record_1 = FactoryGirl.create(:gef_pame_record,
                        gef_area: @gef_area_1, gef_pame_name: @gef_name_1,
                        primary_biome_id: @gef_biome_1.id, mett_original_uid: 222333)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: @wdpa_record_1,
                        gef_pame_record: @pame_record_1)

    gef_area_2 = FactoryGirl.create(:gef_area, gef_pmis_id: 999888)

    gef_region_2 = FactoryGirl.create(:gef_region, name: 'Womanarctica')

    gef_country_2 = FactoryGirl.create(:gef_country, name: 'Bonewomanland', gef_region: @gef_region_1)

    gef_name_2 = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    wdpa_record_2 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999888,
                                        wdpa_name: 'Womanbonal', wdpa_exists: true)

    FactoryGirl.create(:gef_country_wdpa_record, gef_wdpa_record: wdpa_record_2,
                        gef_country: gef_country_2)

    gef_biome_2 = FactoryGirl.create(:gef_biome, name: 'Womanbone Biome')

    pame_record_2 = FactoryGirl.create(:gef_pame_record,
                        gef_area: gef_area_2, gef_pame_name: gef_name_2,
                        primary_biome_id: gef_biome_2.id)

    FactoryGirl.create(:gef_pame_record_wdpa_record, gef_wdpa_record: wdpa_record_2,
                         gef_pame_record: pame_record_2)
  end


  test 'Search for GEF ID gets data' do
    
    FactoryGirl.create(:gef_search, gef_pmis_id: 888999, id: 1)

    visit '/gef/searches/1/'

    assert page.has_selector?('td', text: '888999', count: 1)

    assert page.has_selector?('td', text: '999888', count: 1)

    assert page.has_link?('Manbonal', :href => 'http://www.protectedplanet.net/sites/999888')

    assert page.has_link?('Link', href: '/gef/areas/888999/wdpa_records/999888/pame_records')

    assert page.has_link?('888999', href: 'http://www.thegef.org/gef/project_detail?projID=888999')

  end

  test 'Not duplicate assessments' do

    FactoryGirl.create(:gef_pame_record, gef_area: @gef_area_1, gef_pame_name: @gef_name_1,
                        primary_biome_id: @gef_biome_1.id, mett_original_uid: 333444)
    
    FactoryGirl.create(:gef_search, gef_pmis_id: 888999, id: 1)

    visit '/gef/searches/1/'

    assert page.has_selector?('td', text: '888999', count: 1)

    assert page.has_selector?('td', text: '999888', count: 1)

    assert page.has_link?('Manbonal', :href => 'http://www.protectedplanet.net/sites/999888', count: 1)

    assert page.has_link?('Link', href: '/gef/areas/888999/wdpa_records/999888/pame_records', count: 1)

    assert page.has_link?('888999', href: 'http://www.thegef.org/gef/project_detail?projID=888999')
  end

  test 'opens not in wdpa links' do
    wdpa_record_3 = FactoryGirl.create(:gef_wdpa_record, wdpa_id: 999999,
                                      wdpa_name: nil, wdpa_exists: false)

    FactoryGirl.create(:gef_pame_record, gef_area: @gef_area_1, gef_pame_name: @gef_name_1,
                        primary_biome_id: @gef_biome_1, mett_original_uid: 222333)

    FactoryGirl.create(:gef_search, gef_pmis_id: 888999, id: 1)

    visit '/gef/searches/1/'

    assert page.has_selector?('td', text: '888999', count: 2)

    assert page.has_selector?('td', text: '999888', count: 1)

    assert page.has_selector?('td', text: 'Manbone', count: 1)

    assert page.has_link?('Link', href: '/gef/areas/888999/wdpa_records/999999/pame_records', count: 1)

    assert page.has_link?('888999', href: 'http://www.thegef.org/gef/project_detail?projID=888999')
  end

  test 'renders csv button with link do csv file' do

    FactoryGirl.create(:gef_search, gef_pmis_id: 888999, id: 1)

    visit '/gef/searches/1/'

    assert page.has_link?('Download CSV', /.csv/)

    assert page.has_link?('888999', href: 'http://www.thegef.org/gef/project_detail?projID=888999')
  end

  test 'renders a not found page when nothing matches' do

    FactoryGirl.create(:gef_search, gef_pmis_id: 546465345, id: 1)

    visit '/gef/searches/1/'

    assert page.has_selector?('div', text: /Your search did not find any protected areas/)

    assert page.has_link?('Please try again', href: '/gef/searches/new')

  end
end
