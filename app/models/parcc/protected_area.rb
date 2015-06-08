class Parcc::ProtectedArea < ActiveRecord::Base
  validates :parcc_id, uniqueness: true

  has_many :parcc_species_turnovers, class_name: 'Parcc::SpeciesTurnover', foreign_key: :parcc_protected_area_id
  has_many :parcc_species_protected_areas, class_name: 'Parcc::SpeciesProtectedArea', foreign_key: :parcc_protected_area_id
  has_many :parcc_species, class_name: 'Parcc::Species', through: :parcc_species_protected_areas
end
