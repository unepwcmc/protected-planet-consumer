class Parcc::TaxonomicClass < ActiveRecord::Base
  validates_uniqueness_of :name

  has_many :taxonomic_orders, class_name: 'Parcc::TaxonomicOrder', foreign_key: :parcc_taxonomic_class_id
end
