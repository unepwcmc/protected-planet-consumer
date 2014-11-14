class Parcc::Species < ActiveRecord::Base
  validates_uniqueness_of :name

  belongs_to :parcc_taxonomic_order, class_name: 'Parcc::TaxonomicOrder', foreign_key: :parcc_taxonomic_order_id
end
