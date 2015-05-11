require 'test_helper'
require 'csv'

class TestParccImportersSpeciesCounts < ActiveSupport::TestCase
  test '.import_counts adds counts to the found pa' do
    pa = FactoryGirl.create(:parcc_protected_area, wdpa_id: 111222)

    parsed_csv = [{
      WDPA_ID: 111222,
      WDPA_NAME: 'Abdoulaye',
      COUNT_TOTAL_SPECIES: 1000,
      COUNT_CC_VULNERABLE_SPECIES: 100,
      PERCENT_CC_VULNERABLE_SPECIES: 10
    }]

    CSV.stubs(:foreach)
      .with(anything, headers: true, header_converters: :symbol)
      .returns(parsed_csv)

    Parcc::Importers::Species::Counts.import

    pa = pa.reload
    assert_equal 1000, pa.count_total_species
    assert_equal 100, pa.count_vulnerable_species
    assert_equal 10, pa.percentage_vulnerable_species
  end
end
