require 'test_helper'
require 'csv'

class TestParccImporterSpecies < ActiveSupport::TestCase
  test '.import_taxo_class imports classes' do

    filename = 'huge_csv'

    response = {'SPECIES_TAXON' => ['Bird', 'Fish', 'Bird']}

    CSV.expects(:read).with(filename, headers: true).returns(response)
    
    Parcc::TaxonomicClass.expects(:create).with(name: 'Bird').once
    Parcc::TaxonomicClass.expects(:create).with(name: 'Fish')

    importer = Parcc::Importer::Species.new filename
    importer.import_taxo_class
  end

  test '.import_taxo_order imports classes' do

    filename = 'huge_csv'

    response = {'SPECIES_ORDER' => ['Nematelmintes', 'Platielmintes', 'Platielmintes']}

    CSV.expects(:read).with(filename, headers: true).returns(response)
    
    Parcc::TaxonomicClass.expects(:create).with(name: 'Nematelmintes')
    Parcc::TaxonomicClass.expects(:create).with(name: 'Platielmintes').once

    importer = Parcc::Importer::Species.new filename
    importer.import_taxo_order
  end
end
