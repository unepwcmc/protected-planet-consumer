require 'test_helper'

class Parcc::ProtectedAreaTest < ActiveSupport::TestCase
  PAS_JSON = File.read(
    Rails.root.join('test/fixtures/parcc/api_index.json')
  )

  test '.for_api, given no arguments, returns all protected_areas as JSON string' do
    FactoryGirl.create(:parcc_protected_area, {
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
end
