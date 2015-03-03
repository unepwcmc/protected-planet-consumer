class Gef::Region < ActiveRecord::Base
  has_many :countries, class_name: 'Country', foreign_key: :gef_region_id
end
