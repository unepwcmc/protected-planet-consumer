class Parcc::SpeciesTurnover < ActiveRecord::Base
  belongs_to :protected_area, class_name: 'Parcc::ProtectedArea', foreign_key: :parcc_protected_area_id
  belongs_to :taxonomic_class, class_name: 'Parcc::TaxonomicClass', foreign_key: :taxonomic_class_id
end
