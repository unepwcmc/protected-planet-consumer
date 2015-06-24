FactoryGirl.define do
  factory :parcc_species_turnover, class: Parcc::SpeciesTurnover do
    association :protected_area, factory: :parcc_protected_area
    association :taxonomic_class, factory: :parcc_taxonomic_class

    year 2040
    median 0.500
    upper  0.750
    lower  0.250
  end
end


