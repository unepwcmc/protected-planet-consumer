class Parcc::SpeciesSerializer < ActiveModel::Serializer
  attributes :name, :exposure_2025, :exposure_2055,
    :iucn_cat, :sensitivity, :adaptability
  has_one :taxonomic_order
end
