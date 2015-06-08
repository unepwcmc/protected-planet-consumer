class Parcc::SuitabilityChange < ActiveRecord::Base
  belongs_to :parcc_species, class_name: 'Parcc::Species'
  belongs_to :parcc_protected_area, class_name: 'Parcc::ProtectedArea'
end
