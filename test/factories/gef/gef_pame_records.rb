# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gef_pame_records, class: Gef::PameRecord do
    pa_name_mett 'MyText'
  end
end