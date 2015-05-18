require 'test_helper'

class ParccApiProtectedAreasControllerTest < ActionController::TestCase
  PAS_JSON = File.read(
    Rails.root.join('test/fixtures/parcc/api_index.json')
  )

  def setup
    @controller = Parcc::Api::ProtectedAreasController.new
  end

  test '#index should return a success' do
    get :index
    assert_response :success
  end

  test '#index should render the return value of Parcc::ProtectedArea.for_api' do
    rendered_json = '[{"wdpa_id": 123},{"wdpa_id":345}]'
    Parcc::ProtectedArea.expects(:for_api).returns(rendered_json)

    get :index
    assert_equal rendered_json, @response.body.squish
  end
end
