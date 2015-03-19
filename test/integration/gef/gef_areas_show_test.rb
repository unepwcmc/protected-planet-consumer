require 'test_helper'

class Gef::AreaShowTest < ActionDispatch::IntegrationTest
  test 'returns list of gef pas for given gef_pmis_id' do

    FactoryGirl.create(:gef_area, gef_pmis_id: 1)
    
    get '/gef/area/1'

    assert_equal 200, response.status
  end

  test 'renders GEF Heading' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, gef_pame_name: gef_name, wdpa_id: 999888)

    Gef::WdpaRecord.expects(:wdpa_name).returns([wdpa_id: 999888])

    visit '/gef/area/1'
    
    assert page.has_selector?('h2', text: 'GEF ID #1'), 'h2 does not match'
  end

  test 'renders WDPA name' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, gef_pame_name: gef_name, wdpa_id: 999888, wdpa_name: 'Willbear')

    Gef::WdpaRecord.expects(:wdpa_name).returns([wdpa_id: 999888, wdpa_name: 'Willbear'])

    get '/gef/area/1'

    assert_match /Willbear/, @response.body
  end

  test 'renders WDPA ID' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, gef_pame_name: gef_name, wdpa_id: 999888)

    Gef::WdpaRecord.expects(:wdpa_name).returns([wdpa_id: 999888])

    get '/gef/area/1'

    assert_match /999888/, @response.body
  end

  test 'renders Protected Planet Link' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, gef_pame_name: gef_name, wdpa_id: 999888)

    Gef::WdpaRecord.expects(:wdpa_name).returns([{wdpa_id: 999888, wdpa_exists: true, wdpa_name: 'Willbear', protected_planet_url: 'http://www.protectedplanet.net/sites/999888'}])

    visit '/gef/area/1'

    assert page.has_link?('Willbear', :href => 'http://www.protectedplanet.net/sites/999888'),
      'Has no 999888 PP.net link'
  end

  test 'has links to pame page' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)
    
    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, gef_pame_name: gef_name, wdpa_id: 999888)

    Gef::WdpaRecord.expects(:wdpa_name).returns([{wdpa_id: 999888, wdpa_name: 'Manbone'}])

    visit '/gef/area/1'

    assert page.has_link?('Link', /1/)
  end

  test 'renders gef_name if not in wdpa' do
    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, gef_pame_name: gef_name, wdpa_id: 999888)

    Gef::WdpaRecord.expects(:wdpa_name).with(gef_pmis_id: 1).returns([{wdpa_id: 999888, wdpa_exists: false, wdpa_name: 'Womanbone'}])

    get '/gef/area/1'

    assert_match /Womanbone/, @response.body
  end

  test 'renders csv button with link do csv file' do

    gef_area_1 = FactoryGirl.create(:gef_area, gef_pmis_id: 1)

    gef_name = FactoryGirl.create(:gef_pame_name, name: 'Womanbone')

    FactoryGirl.create(:gef_wdpa_record, gef_area: gef_area_1, gef_pame_name: gef_name, wdpa_id: 999888)

    assert page.has_link?('Download CSV', /.csv/)
  end
end
