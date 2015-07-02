FactoryGirl.define do
  factory :parcc_suitability_change, class: Parcc::SuitabilityChange do
    association :protected_area, factory: :parcc_protected_area
    association :species, factory: :parcc_species

    year 2040
    value 'Inc'
  end
end



