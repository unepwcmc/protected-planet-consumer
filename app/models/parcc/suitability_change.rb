class Parcc::SuitabilityChange < ActiveRecord::Base
  belongs_to :species, class_name: 'Parcc::Species', foreign_key: :parcc_species_id
  belongs_to :protected_area, class_name: 'Parcc::ProtectedArea', foreign_key: :parcc_protected_area_id

  scope :with_changes, -> { where(value: ['Inc', 'Dec']) }
end
