class Parcc::ProtectedArea < ActiveRecord::Base
  validates_uniqueness_of :wdpa_id, :parcc_id

end
