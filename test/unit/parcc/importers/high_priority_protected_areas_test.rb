require 'test_helper'
require 'csv'

class TestParccImportersHighPriorityProtectedAreas < ActiveSupport::TestCase
  test '#import sets high_priority to true to protected areas in the list' do
    pa1 = FactoryGirl.create(
      :parcc_protected_area,
      {name: 'Abdoulaye', designation: 'National Reserve'}
    )

    CSV.expects(:foreach).returns([
        {name: 'Abdoulaye', designation: 'National Reserve'}
    ])

    importer = Parcc::Importers::HighPriorityProtectedAreas.new
    importer.import

    assert_equal true, pa1.reload.high_priority
  end
end
