require 'test_helper'
require 'csv'

class TestParccImportersTurnover < ActiveSupport::TestCase
  test '.populate_values adds values to species turnover for amphibians' do
    FactoryGirl.create(
      :parcc_protected_area,
      {id: 1, parcc_id: 666777, wdpa_id: 888999, name: 'Abdoulaye'}
    )

    amphibian = FactoryGirl.create(:parcc_taxonomic_class, name: 'Amphibian')
    filename = 'lib/data/parcc/Amphibian species turnover 2040 wt WDPAID.csv'

    CSV.expects(:foreach).returns([{
      :'' => '666777',
      name: 'Abdoulaye',
      country: 'NGO',
      polyID: '123',
      point: 'polygon',
      WDPAID: '888999',
      median: '0.222',
      upper: '0.333',
      lower: '0.111'
    }])

    Parcc::SpeciesTurnover.expects(:create).with({
      taxonomic_class_id: amphibian.id,
      year: '2040',
      parcc_protected_area_id: 1,
      upper: '0.333',
      median: '0.222',
      lower: '0.111'
    })

    importer = Parcc::Importers::Turnover.new
    importer.populate_values filename
  end
end
