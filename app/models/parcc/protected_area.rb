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

  has_many :species_protected_areas,
    class_name: 'Parcc::SpeciesProtectedArea',
    foreign_key: :parcc_protected_area_id
  has_many :species_turnovers,
    class_name: 'Parcc::SpeciesTurnover',
    foreign_key: :parcc_protected_area_id
  has_many :species, class_name: 'Parcc::Species',
    through: :species_protected_areas

  def self.for_api
    select(COLUMNS_FOR_API).to_json only: COLUMNS_FOR_API
  end

  def for_api with_species: with_species
    to_json({only: COLUMNS_FOR_API}.tap{ |opts|
      opts[:include] = :species if with_species
    })
  end
end
