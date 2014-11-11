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

    importer = Parcc::Importer.new
    importer.create_pas filename
  end
end