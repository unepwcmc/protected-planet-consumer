# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gef_pame_record, class: Gef::PameRecord do
    pa_name_mett 'MyText'
  end
end