class Parcc::TaxonomicOrder < ActiveRecord::Base
  validates_uniqueness_of :name, scope: :parcc_taxonomic_class_id
  belongs_to :taxonomic_class, class_name: 'Parcc::TaxonomicClass', foreign_key: :parcc_taxonomic_class_id
  has_many :species, class_name: 'Parcc::Species', foreign_key: :parcc_taxonomic_order_id
end
