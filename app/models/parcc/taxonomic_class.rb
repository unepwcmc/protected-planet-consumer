class Parcc::TaxonomicClass < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :taxonomic_orders, class_name: 'Parcc::TaxonomicOrder', foreign_key: :parcc_taxonomic_class_id
end
