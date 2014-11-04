# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gef_wdpa_record, class: Gef::WdpaRecord do
    gef_pmis_id 'MyString'
    pa_name_mett 'MyText'
  end
end