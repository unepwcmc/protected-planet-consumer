# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parcc_taxonomic_class, class: Parcc::TaxonomicClass do
    name 'Bird'
  end
end


