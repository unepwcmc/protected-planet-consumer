class Parcc::SpeciesTurnover < ActiveRecord::Base
  belongs_to :parcc_protected_area, class_name: 'Parcc::ProtectedArea', foreign_key: :parcc_protected_area_id
end
