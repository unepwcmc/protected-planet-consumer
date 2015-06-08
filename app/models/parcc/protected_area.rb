class Parcc::ProtectedArea < ActiveRecord::Base
  COLUMNS_FOR_API = [
    :parcc_id,    :name,
    :iso_3,       :poly_id,
    :designation, :geom_type,
    :iucn_cat,    :wdpa_id,
    :count_total_species,
    :count_vulnerable_species,
    :percentage_vulnerable_species
  ]

  validates :parcc_id, uniqueness: true

  has_many :parcc_species_turnovers, class_name: 'Parcc::SpeciesTurnover', foreign_key: :parcc_protected_area_id
  has_many :parcc_species_protected_areas, class_name: 'Parcc::SpeciesProtectedArea', foreign_key: :parcc_protected_area_id
  has_many :parcc_species, class_name: 'Parcc::Species', through: :parcc_species_protected_areas
end
