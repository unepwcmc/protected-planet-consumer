require 'test_helper'
require 'csv'

class TestParccImporterSpecies < ActiveSupport::TestCase

  test '.import_taxo_order imports classes' do

    filename = 'huge_csv'

    response = {species_taxon: 'Bird', species_order: 'Nematelmintes'}

    csv_mock = mock

    csv_mock.expects(:each).yields(response)

    CSV.expects(:read).with(filename, headers: true, header_converters: :symbol).returns(csv_mock)
    
    Parcc::TaxonomicClass.expects(:create).with(name: 'Bird')

    bird_id_mock = mock

    bird_id_mock.expects(:id).returns(1)

    bird_mock = mock
    bird_mock.expects(:first).returns(bird_id_mock)

    Parcc::TaxonomicClass.expects(:where).with('name = ?', 'Bird').returns(bird_mock)

    Parcc::TaxonomicOrder.expects(:create).with(name: 'Nematelmintes', parcc_taxonomic_class_id: 1).once

    importer = Parcc::Importer::Species.new filename: filename
    importer.import_taxo
  end
end
