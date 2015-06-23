class Parcc::SpeciesTurnover < ActiveRecord::Base
  belongs_to :parcc_protected_area, class_name: 'Parcc::ProtectedArea', foreign_key: :parcc_protected_area_id
  belongs_to :parcc_taxonomic_class, class_name: 'Parcc::TaxonomicClass', foreign_key: :taxonomic_class_id
end
