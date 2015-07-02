require 'test_helper'

class ParccProtectedAreasControllerTest < ActionController::TestCase
  def setup
    @controller = Parcc::ProtectedAreasController.new

    @pa = FactoryGirl.create(:parcc_protected_area)

    taxonomic_classes = [
      FactoryGirl.create(:parcc_taxonomic_class, name: 'Amphibian'),
      FactoryGirl.create(:parcc_taxonomic_class, name: 'Bird'),
      FactoryGirl.create(:parcc_taxonomic_class, name: 'Mammal')
    ]

    taxonomic_classes.each_with_object([]) do |tc, turnovers|
      turnovers |= [
        FactoryGirl.create(:parcc_species_turnover,
          protected_area: @pa, taxonomic_class: tc, year: 2040
        ),
        FactoryGirl.create(:parcc_species_turnover,
          protected_area: @pa, taxonomic_class: tc, year: 2070
        ),
        FactoryGirl.create(:parcc_species_turnover,
          protected_area: @pa, taxonomic_class: tc, year: 2100
        )
      ]
    end
  end

  test '#show returns a success' do
    get :show, id: @pa.wdpa_id
    assert_response :success
  end

  test '#download returns a success' do
    get :download, id: @pa.wdpa_id
    assert_response :success
  end
end
