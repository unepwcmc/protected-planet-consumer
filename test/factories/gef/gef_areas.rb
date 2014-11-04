# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gef_area, class: Gef::Area do
    id 'MyInteger'
    gef_pmis_id 'MyInteger'
  end
end