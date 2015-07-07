# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parcc_protected_area, class: Parcc::ProtectedArea do
    sequence(:parcc_id) { |n| n }
    sequence(:name) { |n| "Name #{n}"}
    sequence(:wdpa_id) { |n| n }

    factory :parcc_protected_area_with_high_priority do
      high_priority true
    end

    after(:create) { |pa, evaluator|
      create_list(:parcc_species_turnover, 1, protected_area: pa)
    }
  end
end
