class Parcc::SpeciesProtectedArea < ActiveRecord::Base
  belongs_to :parcc_species, class_name: 'Parcc::Species', foreign_key: :parcc_species_id
  belongs_to :parcc_protected_area, class_name: 'Parcc::ProtectedArea', foreign_key: :parcc_protected_area_id
end
