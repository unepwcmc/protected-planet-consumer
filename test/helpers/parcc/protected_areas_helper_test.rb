require 'test_helper'

class Parcc::ProtectedAreasHelperTest < ActionView::TestCase

  def setup
    @species = FactoryGirl.create(:parcc_species)
    @protected_area = FactoryGirl.create(:parcc_protected_area)
  end

  def test_exposure_check_icon_if_present
    assert_equal %Q(<i class="fa fa-check"></i>), exposure_check(true)
  end

  def test_exposure_check_icon_if_not_present
    assert_equal %Q(<i class="no-icon"></i>), exposure_check(false)
  end

  def test_iucn_red_list_icon
    value = "EN"
    assert_match /#{value} <i class="fa fa-circle orange"><\/i>/, iucn_value_icon(value)
  end

  def test_suitability_value_icon
    value = "Inc"
    assert_match /#{value.upcase} <i class="fa fa-arrow-circle-up green"><\/i>/, suitability_value_icon(value)
  end

  def test_traits_to_return_list
    taxonomic_class = FactoryGirl.build(:parcc_taxonomic_class, name: "Amphibian")
    taxonomic_order = FactoryGirl.build(:parcc_taxonomic_order, taxonomic_class: taxonomic_class)
    species = FactoryGirl.build(:parcc_species, taxonomic_order: taxonomic_order, adaptability: "1")
    assert_equal "<li>Barriers to dispersal</li>", traits("adaptability", species)
  end

  def high_priority_warning_to_return_div_if_high_priority
    protected_area = FactoryGirl.create(:parcc_protected_area_with_high_priority)
    assert_equal %Q(
      <div class="other-info">
        <p class="info">
          <i class="fa fa-exclamation-circle"></i>
          <strong>#{protected_area.name}</strong> is among the top 75 protected areas
            assessed as being the <strong>most vulnerable to climate change by 2025</strong>
            (with a 95% uncertainty level)
        </p>
      </div>
    ), high_priority_warning(protected_area)
  end

  def high_priority_warning_to_return_nothing_if_not_high_priority
    assert_nil high_priority_warning(@protected_area)
  end

end
