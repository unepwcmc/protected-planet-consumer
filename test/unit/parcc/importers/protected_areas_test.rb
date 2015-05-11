require 'test_helper'

class ParccImportersProtectedAreasTest < ActiveSupport::TestCase
  PA_123_JSON = JSON.parse(
    File.read(Rails.root.join('test/fixtures/parcc/pp_area_123.json')),
    symbolize_names: true
  )

  PA_234_JSON = JSON.parse(
    File.read(Rails.root.join('test/fixtures/parcc/pp_area_234.json')),
    symbolize_names: true
  )

  test '::from_wdpa_id, given a wdpa_id, returns a newly created protected area' do
    ProtectedPlanetReader.stubs(:new).returns(mock.tap { |mock|
      mock.stubs(:protected_area_from_wdpaid).returns(PA_123_JSON)
    })

    new_pa = Parcc::Importers::ProtectedAreas.from_wdpa_id 123

    assert_kind_of Parcc::ProtectedArea, new_pa
    assert_equal PA_123_JSON[:wdpa_id], new_pa.wdpa_id
  end

  test '::from_wdpa_id, given an array of wdpa_ids, returns newly created protected areas' do
    ProtectedPlanetReader.stubs(:new).returns(mock.tap { |mock|
      mock.stubs(:protected_area_from_wdpaid).returns(PA_123_JSON, PA_234_JSON)
    })

    new_pas = Parcc::Importers::ProtectedAreas.from_wdpa_id [123, 234]

    assert_kind_of Array, new_pas

    new_pas.sort_by!(&:wdpa_id)
    assert_equal [123, 234], new_pas.map(&:wdpa_id)
  end
end
