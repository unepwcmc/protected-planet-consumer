class Parcc::ProtectedArea < ActiveRecord::Base
  validates_uniqueness_of :wdpa_id, :parcc_id
  has_many :parcc_species_turnovers, class_name: 'Parcc::SpeciesTurnover', foreign_key: :parcc_protected_area_id

end
