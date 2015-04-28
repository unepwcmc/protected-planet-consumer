require 'test_helper'
require 'csv'

class TestParccImporterSpecies < ActiveSupport::TestCase

  test '.import_taxo imports classes' do
    filename = 'huge.csv'
    response = [{
      species_taxon: 'Bird',
      species_order: 'Nematelmintes',
      species_binomial: 'Unepus Wicimesensis',
      cc_vulnerability: 'no',
      species_iucn_cat: 'VIII',
      wdpa_id: 999888,
      overlap_wdpa_percent: 50,
      species_wdpa_intersept_area_sum: 2333.5
    }]

    CSV.expects(:foreach).with(filename, headers: true, header_converters: :symbol).returns(response)
    Parcc::TaxonomicClass.expects(:create).with(name: 'Bird')

    bird_id_mock = mock
    bird_id_mock.expects(:id).returns(1)
    bird_mock = mock
    bird_mock.expects(:first).returns(bird_id_mock)

    nema_id_mock = mock
    nema_id_mock.expects(:id).returns(2)
    nema_mock = mock
    nema_mock.expects(:first).returns(nema_id_mock)

    Parcc::TaxonomicClass.expects(:where).with(name: 'Bird').returns(bird_mock)
    Parcc::TaxonomicOrder.expects(:where).with(name: 'Nematelmintes').returns(nema_mock)
    Parcc::TaxonomicOrder.expects(:create).with(name: 'Nematelmintes', parcc_taxonomic_class_id: 1)
    Parcc::Species.expects(:create).with(
      name: 'Unepus Wicimesensis',
      parcc_taxonomic_order_id: 2,
      cc_vulnerable: false,
      iucn_cat: 'VIII'
    )

    FactoryGirl.create(:parcc_protected_area, wdpa_id: 999888, id: 54321)
    FactoryGirl.create(:parcc_species, id: 12345, name: 'Unepus Wicimesensis')

    Parcc::SpeciesProtectedArea.expects(:create).with(
      parcc_protected_areas_id: 54321,
      parcc_species_id: 12345,
      overlap_percentage: 50,
      intersection_area: 2333.5
    )

    Parcc::Importer::Species.import_taxo filename
  end

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
      .with('species_counts.csv', headers: true, header_converters: :symbol)
      .returns(parsed_csv)

    Parcc::Importer::Species.import_counts 'species_counts.csv'

    pa = pa.reload
    assert_equal 1000, pa.count_total_species
    assert_equal 100, pa.count_vulnerable_species
    assert_equal 10, pa.percentage_vulnerable_species
  end
end
