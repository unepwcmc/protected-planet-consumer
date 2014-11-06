require 'test_helper'

class GefHomeTest < ActionDispatch::IntegrationTest

  test 'returns a page' do
    get '/gef'
    assert_response 200, response.status
  end

  test "filling GEF ID and clicking visits protected area page" do
    
    visit '/gef/'

    fill_in :gef_pmis_id, :with => "838"
    click_button 'create Post'

  end
end
