require 'test_helper'
require 'csv'

class TestParccImportersSpeciesCounts < ActiveSupport::TestCase
  test '.import_counts adds counts to the found pa' do
    pa = FactoryGirl.create(:parcc_protected_area, wdpa_id: 111222)

    csv = [{
      wdpa_id: 111222,
      wdpa_name: 'abdoulaye',
      count_total_species: 1000,
      count_cc_vulnerable_species: 100,
      percent_cc_vulnerable_species: 10
    }]

    CSV.stubs(:foreach).returns(csv)

    Parcc::Importers::Species::Counts.import

    pa = pa.reload
    assert_equal 1000, pa.count_total_species
    assert_equal 100, pa.count_vulnerable_species
    assert_equal 10, pa.percentage_vulnerable_species
  end
end
