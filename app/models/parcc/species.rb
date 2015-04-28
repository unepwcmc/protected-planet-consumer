class Parcc::Species < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :parcc_protected_areas, class_name: 'Parcc::ProtectedArea', through: :parcc_species_protected_areas
  belongs_to :parcc_taxonomic_order, class_name: 'Parcc::TaxonomicOrder', foreign_key: :parcc_taxonomic_order_id
end
