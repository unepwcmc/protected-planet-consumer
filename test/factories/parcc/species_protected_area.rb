# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parcc_species_protected_area, class: Parcc::SpeciesProtectedArea do
    association :protected_area, factory: :parcc_protected_area
    association :species, factory: :parcc_species
  end
end


