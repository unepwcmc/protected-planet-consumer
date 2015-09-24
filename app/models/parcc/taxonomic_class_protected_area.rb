class Parcc::TaxonomicClassProtectedArea < ActiveRecord::Base

  belongs_to :taxonomic_class, class_name: 'Parcc::TaxonomicClass', foreign_key: :parcc_taxonomic_class_id
  belongs_to :protected_area, class_name: 'Parcc::ProtectedArea', foreign_key: :parcc_protected_area_id

end
