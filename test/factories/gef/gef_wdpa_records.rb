# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gef_wdpa_record, class: Gef::WdpaRecord do
    wdpa_id 'MyInteger'
  end
end