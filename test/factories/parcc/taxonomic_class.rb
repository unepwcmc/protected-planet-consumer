# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parcc_taxonomic_class, class: Parcc::TaxonomicClass do
    sequence(:name) { |n| "Class n.#{n}" }
  end
end


