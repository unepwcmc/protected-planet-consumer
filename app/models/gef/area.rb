class Gef::Area < ActiveRecord::Base
  has_many :gef_protected_areas
  validates_uniqueness_of :gef_pmis_id
end
