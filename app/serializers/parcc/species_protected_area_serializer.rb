class Parcc::SpeciesProtectedAreaSerializer < ActiveModel::Serializer
  attributes :overlap_percentage
  has_one :species
end
