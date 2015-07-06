require 'test_helper'

class Parcc::ProtectedAreaTest < ActiveSupport::TestCase
  PA_123_JSON = File.read(
    Rails.root.join('test/fixtures/parcc/api_protected_area_123.json')
  )

  PAS_JSON = File.read(
    Rails.root.join('test/fixtures/parcc/api_index.json')
  )

  def setup
    @protected_area = FactoryGirl.create(:parcc_protected_area, {
      parcc_id: 1,
      name: "Manbone",
      iso_3: "NB",
      poly_id: 12,
      designation: "National Park",
      geom_type: "polygon",
      iucn_cat: "II",
      wdpa_id: 123,
      count_total_species: 5000,
      count_vulnerable_species: 500,
      percentage_vulnerable_species: 10
    })
  end

  test '::for_api, given no arguments, returns all protected_areas as JSON string' do
    FactoryGirl.create(:parcc_protected_area, {
      parcc_id: 2,
      name: "San Guillermo",
      iso_3: "AR",
      poly_id: 12,
      designation: "National Park",
      geom_type: "polygon",
      iucn_cat: "III",
      wdpa_id: 345,
      count_total_species: 200,
      count_vulnerable_species: 20,
      percentage_vulnerable_species: 10
    })

    assert_equal JSON.parse(PAS_JSON), JSON.parse(Parcc::ProtectedArea.for_api)
  end

  test '#for_api, given no arguments, returns the protected area as JSON string' do
    assert_equal JSON.parse(PA_123_JSON), JSON.parse(@protected_area.for_api)
  end

  test '#for_api, given with_species: true, returns the protected area JSON with species' do
    species_protected_area = FactoryGirl.create(
      :parcc_species_protected_area, protected_area: @protected_area
    )

    protected_area_json = JSON.parse(@protected_area.for_api(with_species: true))

    assert_equal(
      JSON.parse(species_protected_area.to_json),
      protected_area_json['species_protected_areas'].first
    )
  end
end
