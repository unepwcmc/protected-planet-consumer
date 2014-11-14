class Parcc::TaxonomicOrder < ActiveRecord::Base
  validates_uniqueness_of :name

  belongs_to :parcc_taxonomic_class, class_name: 'Parcc::TaxonomicClass', foreign_key: :parcc_taxonomic_class_id
  has_many :parcc_species, class_name: 'Parcc::Species', foreign_key: :parcc_taxonomic_order_id
end
