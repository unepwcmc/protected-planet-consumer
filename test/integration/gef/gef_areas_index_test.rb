require 'test_helper'

class Gef::AreaIndexTest < ActionDispatch::IntegrationTest

  test 'has_link in default page to download' do

    visit '/gef'

    assert page.has_link?('Download All Areas in CSV format', :href => '/public/gef/gef_full_database.csv'),
      'Has no csv downlad link'

  end
end