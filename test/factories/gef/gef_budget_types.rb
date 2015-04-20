# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gef_budget_type, class: Gef::BudgetType do
    name 'MyString'
  end
end