require 'test_helper'

class ParccImportersSuitabilityChangesTest < ActiveSupport::TestCase
  test '::import creates species from headers' do
    csv = [[
      'name',
      'country',
      'designation',
      'polyID',
      'point',
      'San_Guillermona',
      'Sir_Telefonino',
      'wdpaid',
      'iucn_cat'
    ]]

    Dir.stubs(:[]).returns(['filename'])
    CSV.stubs(:read).returns(csv)

    Parcc::Species.expects(:find_or_create_by).with(name: 'San Guillermona')
    Parcc::Species.expects(:find_or_create_by).with(name: 'Sir Telefonino')

    Parcc::Importers::SuitabilityChanges.import
  end

  test '::import creates SuitabilityChange records' do
    filename = 'Amphibian\ change\ in\ suitability\ 2040.csv'
    guillermona = FactoryGirl.create(:parcc_species, name: 'San Guillermona')
    telefonino = FactoryGirl.create(:parcc_species, name: 'Sir Telefonino')
    san_guillermo = FactoryGirl.create(:parcc_protected_area, wdpa_id: 1234)

    csv = [[
      'name', 'country',
      'designation', 'polyID',
      'point', 'San_Guillermona',
      'Sir_Telefonino', 'wdpaid',
      'iucn_cat'
    ], [
      'San guillermo', 'ARG',
      'National Park', '1245',
      'polygon', 'None',
      'Inc', '1234',
      'II'
    ]]

    Dir.stubs(:[]).returns([filename])
    CSV.stubs(:read).returns(csv)

    Parcc::SuitabilityChange.expects(:create).with(
      species: guillermona,
      value: 'None',
      year: '2040',
      parcc_protected_area_id: san_guillermo.id
    )
    Parcc::SuitabilityChange.expects(:create).with(
      species: telefonino,
      value: 'Inc',
      year: '2040',
      parcc_protected_area_id: san_guillermo.id
    )

    Parcc::Importers::SuitabilityChanges.import
  end
end
