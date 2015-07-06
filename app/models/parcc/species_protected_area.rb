class Parcc::SpeciesProtectedArea < ActiveRecord::Base

  belongs_to :species, class_name: 'Parcc::Species', foreign_key: :parcc_species_id
  belongs_to :protected_area, class_name: 'Parcc::ProtectedArea', foreign_key: :parcc_protected_area_id

  scope :by_taxonomic_class, -> taxonomic_class {
    joins(species: {taxonomic_order: :taxonomic_class}).
      where("parcc_taxonomic_classes.name = ?", taxonomic_class)
  }

  def self.vulnerability_table_for protected_area_id, taxonomic_class=nil
    scoped = where(parcc_protected_area_id: protected_area_id)
    scoped = scoped.by_taxonomic_class(taxonomic_class) if taxonomic_class.present?
  end
end
