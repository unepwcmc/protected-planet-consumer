require 'test_helper'

class Parcc::SpeciesTurnoverTest < ActiveSupport::TestCase
  test '#percentage, given :median, :upper or :lower, returns a percentage value' do
    species_turnover = FactoryGirl.build(:parcc_species_turnover, median: 0.344)
    assert_equal 34.4, species_turnover.percentage(:median)
  end
end
