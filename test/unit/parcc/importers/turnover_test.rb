require 'test_helper'
require 'csv'

class TestParccImportersTurnover < ActiveSupport::TestCase

  test '.populate_values adds values to species turnover for amphibians' do
    FactoryGirl.create(
      :parcc_protected_area,
      {id: 1, parcc_id: 666777, wdpa_id: 888999, name: 'Abdoulaye'}
    )

    filename = 'lib/data/parcc/Amphibian species turnover 2040 wt WDPAID.csv'
    parsed_csv = [{
      '' => '666777',
      'name' => 'Abdoulaye',
      'country' => 'NGO',
      'polyID' => '123',
      'point' => 'polygon',
      'WDPAID' => '888999',
      'median' => '0.222',
      'upper' => '0.333',
      'lower' => '0.111'
    }]

    values_to_save_1 = {
      taxonomic_class: 'Amphibian',
      year: '2040',
      stat: 'median',
      value: '0.222',
      parcc_protected_area_id: 1
    }

    values_to_save_2 = {
      taxonomic_class: 'Amphibian',
      year: '2040',
      stat: 'lower',
      value: '0.111',
      parcc_protected_area_id: 1,
    }

    values_to_save_3 = {
      taxonomic_class: 'Amphibian',
      year: '2040',
      stat: 'upper',
      value: '0.333',
      parcc_protected_area_id: 1,
    }

    CSV.expects(:foreach).with(filename, headers: true).returns(parsed_csv)

    Parcc::SpeciesTurnover.expects(:create).with(values_to_save_1)
    Parcc::SpeciesTurnover.expects(:create).with(values_to_save_2)
    Parcc::SpeciesTurnover.expects(:create).with(values_to_save_3)

    importer = Parcc::Importers::Turnover.new
    importer.populate_values filename
  end
end
