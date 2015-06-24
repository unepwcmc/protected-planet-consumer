class Parcc::SuitabilityChange < ActiveRecord::Base
  belongs_to :species, class_name: 'Parcc::Species'
  belongs_to :protected_area, class_name: 'Parcc::ProtectedArea'
end
