require 'test_helper'
require 'csv'

class TestParccImporterSpecies < ActiveSupport::TestCase

  test '.import_taxo_order imports classes' do

    filename = 'huge_csv'

    response = [
                {species_taxon: 'Bird', species_order: 'Nematelmintes'},
                {species_taxon: 'Bird', species_order: 'Nematelmintes'},
                {species_taxon: 'Bird', species_order: 'Platielmintes'},
                {species_taxon: 'Fish', species_order: 'Codielmintes'}
               ]
   
    csv_mock = mock

    csv_mock.expects(:each).multiple_yields(response)

    CSV.expects(:read).with(filename, headers: true, header_converters: :symbol).returns(csv_mock)
    
    Parcc::TaxonomicClass.expects(:create).with(name: 'Bird').once
    Parcc::TaxonomicClass.expects(:create).with(name: 'Fish')

    fish_id_mock = mock
    bird_id_mock = mock

    bird_id_mock.expects(:id).returns(1)
    fish_id_mock.expects(:id).returns(2)

    fish_mock = mock
    fish_mock.expects(:first).returns(fish_id_mock)

    bird_mock = mock
    bird_mock.expects(:first).returns(bird_id_mock)

    Parcc::TaxonomicClass.expects(:where).with('name = ?', 'Bird').returns(bird_mock)
    Parcc::TaxonomicClass.expects(:where).with('name = ?', 'Fish').returns(fish_mock)

    Parcc::TaxonomicOrder.expects(:create).with(name: 'Nematelmintes', parcc_taxonomic_class_id: 1).once
    Parcc::TaxonomicOrder.expects(:create).with(name: 'Platielmintes', parcc_taxonomic_class_id: 1)
    Parcc::TaxonomicOrder.expects(:create).with(name: 'Codielmintes', parcc_taxonomic_class_id: 2)

    importer = Parcc::Importer::Species.new filename: filename
    importer.import_taxo
  end
end
