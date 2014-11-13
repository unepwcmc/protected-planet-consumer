require 'test_helper'
require 'csv'

class TestParccImporter < ActiveSupport::TestCase

  test '.create_pas imports protected_areas'  do


    filename = 'Amphibian species turnover 2040 wt WDPAID.csv'

    parsed_csv = [
                  {"" => '666777', 'name' => 'Abdoulaye', 'country' => 'NGO', 'polyID' => '123', 
                    'point' => 'polygon', 'WDPAID' => '888999', 'median' => '0.222', 
                    'upper' => '0.333', 'lower' => '0.111'},
                  {"" => '555888', 'name' => 'Yero', 'country' => 'AGU', 'polyID' => '119', 
                    'point' => 'polygon', 'WDPAID' => '999888', 'median' => '0.422', 
                    'upper' => '0.433', 'lower' => '0.411'}
                 ]

    CSV.expects(:read).with(filename, headers: true).returns(parsed_csv)


    values_to_save_1 = {
                          parcc_id: '666777',
                          name: 'Abdoulaye',
                          iso_3: 'NGO',
                          poly_id: '123',
                          geom_type: 'polygon',
                          wdpa_id: '888999'
                        }

    values_to_save_2 = {
                          parcc_id: '555888',
                          name: 'Yero',
                          iso_3: 'AGU',
                          poly_id: '119',
                          geom_type: 'polygon',
                          wdpa_id: '999888'
                        }


    
    Parcc::ProtectedArea.expects(:create).with(values_to_save_1)
    Parcc::ProtectedArea.expects(:create).with(values_to_save_2)

    importer = Parcc::Importer::Turnover.new
    importer.create_pas file_path: filename
  end

  test '.populate_values adds values to species turnover for amphibians' do
    FactoryGirl.create(:parcc_protected_area, id: 1, parcc_id: 666777, wdpa_id: 888999, name: 'Abdoulaye')
    FactoryGirl.create(:parcc_protected_area, id: 2, parcc_id: 555888, wdpa_id: 999888, name: 'Yero')


    filename = 'lib/data/parcc/Amphibian species turnover 2040 wt WDPAID.csv'

    parsed_csv = [
                  {"" => '666777', 'name' => 'Abdoulaye', 'country' => 'NGO', 'polyID' => '123', 
                    'point' => 'polygon', 'WDPAID' => '888999', 'median' => '0.222', 
                    'upper' => '0.333', 'lower' => '0.111'}
                 ]
    CSV.expects(:read).with(filename, headers: true).returns(parsed_csv)


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

    Parcc::SpeciesTurnover.expects(:create).with(values_to_save_1)
    Parcc::SpeciesTurnover.expects(:create).with(values_to_save_2)
    Parcc::SpeciesTurnover.expects(:create).with(values_to_save_3)

    importer = Parcc::Importer::Turnover.new
    importer.populate_values file_path: filename
  end
end