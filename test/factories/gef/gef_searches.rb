# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gef_search, class: Gef::Search do
    gef_pmis_id 'MyInteger'
  end
end