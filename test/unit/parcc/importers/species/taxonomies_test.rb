require 'test_helper'
require 'csv'

class TestParccImportersSpeciesTaxonomies < ActiveSupport::TestCase
  def setup
    @pa = FactoryGirl.create(:parcc_protected_area, wdpa_id: 999888)
    csv = [{
      species_binomial: 'Unepus Wicimesensis',
      cc_vulnerability: 'no',
      species_iucn_cat: 'VIII',
      sensitivity: 'High',

      species_taxon: 'Bird',
      species_order: 'Nematelmintes',

      wdpa_id: 999888,
      overlap_wdpa_percent: 50,
      species_wdpa_intersept_area_sum: 2333.5
    }]

    CSV.stubs(:foreach).returns(csv)
  end

  test '#import imports classes' do
    Parcc::TaxonomicClass.expects(:find_or_create_by)
      .with(name: 'Bird')

    Parcc::Importers::Species::Taxonomies.import
  end

  test '#import imports orders' do
    bird_class_mock = mock
    Parcc::TaxonomicClass.stubs(:find_or_create_by).returns(bird_class_mock)

    Parcc::TaxonomicOrder.expects(:find_or_create_by)
      .with(name: 'Nematelmintes', parcc_taxonomic_class: bird_class_mock)

    Parcc::Importers::Species::Taxonomies.import
  end

  test '#import imports species' do
    unepus_species = FactoryGirl.create(:parcc_species)

    create_with_mock = mock
    create_with_mock.expects(:find_or_create_by)
      .with(name: 'Unepus Wicimesensis')
      .returns(unepus_species)

    nematelmintes_mock = mock
    Parcc::TaxonomicOrder.stubs(:find_or_create_by).returns(nematelmintes_mock)

    converted_record = {
      cc_vulnerable: false,
      sensitivity: 'High',
      iucn_cat: 'VIII',
      name: 'Unepus Wicimesensis',
      parcc_taxonomic_order: nematelmintes_mock
    }

    Parcc::Species.expects(:create_with)
      .with(converted_record)
      .returns(create_with_mock)

    Parcc::Importers::Species::Taxonomies.import
  end

  test '#import joins species to protected area' do
    unepus_species = FactoryGirl.create(
      :parcc_species,
      name: 'Unepus Wicimesensis'
    )

    Parcc::SpeciesProtectedArea.expects(:create).with(
      parcc_species: unepus_species,
      parcc_protected_area: @pa,
      intersection_area: 2333.5,
      overlap_percentage: 50
    )

    Parcc::Importers::Species::Taxonomies.import
  end
end
