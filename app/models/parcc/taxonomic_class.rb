class Parcc::TaxonomicClass < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :taxonomic_orders, class_name: 'Parcc::TaxonomicOrder', foreign_key: :parcc_taxonomic_class_id

  has_many :taxonomic_class_protected_areas, class_name: 'Parcc::TaxonomicClassProtectedArea', foreign_key: :parcc_taxonomic_class_id
  has_many :protected_areas, class_name: 'Parcc::ProtectedArea', through: :taxonomic_class_protected_areas
end
