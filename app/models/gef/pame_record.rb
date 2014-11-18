class Gef::PameRecord < ActiveRecord::Base
  belongs_to :gef_area, class_name: 'Gef::Area', foreign_key: :gef_area_id
end