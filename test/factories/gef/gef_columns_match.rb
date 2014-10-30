# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gef_column_match, class: Gef::ColumnMatch do
    model_columns 'MyString'
    xls_columns 'MyText'
  end
end