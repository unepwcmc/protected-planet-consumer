require 'test_helper'

class ParccDownloadsGeneratorsProtectedAreaInfoTest < ActiveSupport::TestCase
  test '::generate, given a ProtectedArea, returns a path to the created csv' do
    pa = FactoryGirl.build(:parcc_protected_area)
    expected_path = Rails.root.join("tmp/downloads/#{pa.wdpa_id}_protected_area_info.csv")

    CSV.stubs(:open)
    assert_equal expected_path, Parcc::Downloads::Generators::ProtectedAreaInfo.generate(pa)
  end

  test '::generate, given a ProtectedArea, creates a csv file' do
    pa = FactoryGirl.create(
      :parcc_protected_area,
      wdpa_id: 123,
      name: 'Gola',
      iucn_cat: 'IV',
      iso_3: 'GHA',
      designation: 'National Park',
      count_total_species: 1000,
      count_vulnerable_species: 100,
      percentage_vulnerable_species: 10,
      high_priority: false
    )

    csv_mock = mock
    csv_mock.expects(:<<).with(Parcc::Downloads::Generators::ProtectedAreaInfo::HEADERS)
    csv_mock.expects(:<<).with([123, 'Gola', 'GHA', 'National Park', 'IV', 1000, 100, 10, false])
    CSV.stubs(:open).yields(csv_mock)

    Parcc::Downloads::Generators::ProtectedAreaInfo.generate(pa)
  end
end
