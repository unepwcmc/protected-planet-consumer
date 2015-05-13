# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parcc_species, class: Parcc::Species do
    name 'AntiloCAPRA!'
  end
end

