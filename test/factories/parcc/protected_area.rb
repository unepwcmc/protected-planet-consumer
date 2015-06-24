# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parcc_protected_area, class: Parcc::ProtectedArea do
    parcc_id 'MyInteger'
    name 'MyString'
    wdpa_id 'MyInteger'

    after(:create) { |pa, evaluator|
      create_list(:parcc_species_turnover, 1, protected_area: pa)
    }
  end
end
