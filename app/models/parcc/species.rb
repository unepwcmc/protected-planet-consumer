class Parcc::Species < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :species_protected_areas, class_name: 'Parcc::SpeciesProtectedArea', foreign_key: :parcc_species_id
  has_many :protected_areas, through: :species_protected_areas
  has_many :suitability_changes, class_name: 'Parcc::SuitabilityChange', foreign_key: :parcc_species_id

  belongs_to :taxonomic_order, class_name: 'Parcc::TaxonomicOrder', foreign_key: :parcc_taxonomic_order_id
  delegate :taxonomic_class, to: :taxonomic_order
end
