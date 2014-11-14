require 'test_helper'
require 'csv'

class TestParccImporterSpecies < ActiveSupport::TestCase

  test '.import_taxo_order imports classes' do

    filename = 'huge_csv'

    response = {species_taxon: 'Bird', species_order: 'Nematelmintes', species_binomial: 'Unepus Wicimesensis', cc_vulnerability: 'no', species_iucn_cat: 'VIII'}

    csv_mock = mock

    csv_mock.expects(:each).yields(response)

    CSV.expects(:read).with(filename, headers: true, header_converters: :symbol).returns(csv_mock)
    
    Parcc::TaxonomicClass.expects(:create).with(name: 'Bird')

    bird_id_mock = mock
    bird_id_mock.expects(:id).returns(1)
    bird_mock = mock
    bird_mock.expects(:first).returns(bird_id_mock)

    nema_id_mock = mock
    nema_id_mock.expects(:id).returns(2)
    nema_mock = mock
    nema_mock.expects(:first).returns(nema_id_mock)

    Parcc::TaxonomicClass.expects(:where).with('name = ?', 'Bird').returns(bird_mock)
    Parcc::TaxonomicOrder.expects(:where).with('name = ?', 'Nematelmintes').returns(nema_mock)

    Parcc::TaxonomicOrder.expects(:create).with(name: 'Nematelmintes', parcc_taxonomic_class_id: 1)

    Parcc::Species.expects(:create).with(name: 'Unepus Wicimesensis', parcc_taxonomic_order_id: 2, cc_vulnerable: false, iucn_cat: 'VIII')

    importer = Parcc::Importer::Species.new filename: filename
    importer.import_taxo
  end
end
