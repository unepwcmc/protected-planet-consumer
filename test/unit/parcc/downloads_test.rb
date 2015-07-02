require 'test_helper'

class ParccDownloadsTest < ActiveSupport::TestCase
  test '::generate, given a ProtectedArea, calls all the generators' do
    pa = FactoryGirl.build(:parcc_protected_area)

    Parcc::Downloads.stubs(:create_zip)

    FileUtils.stubs(:rm)
    File.stubs(:exists?).returns(true, false)
    Parcc::Downloads::Generators::SuitabilityChanges.expects(:generate).with(pa)
    Parcc::Downloads::Generators::Turnovers.expects(:generate).with(pa)
    Parcc::Downloads::Generators::Vulnerability.expects(:generate).with(pa)
    Parcc::Downloads::Generators::ProtectedAreaInfo.expects(:generate).with(pa)

    Parcc::Downloads.generate(pa)
  end
end
