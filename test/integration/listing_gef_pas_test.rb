require 'test_helper'

class ListingGefPasTest < ActionDispatch::IntegrationTest
  test 'returns a list of all gef pas' do
    get '/api/gef'
    assert_response 200, response.status
  end
end