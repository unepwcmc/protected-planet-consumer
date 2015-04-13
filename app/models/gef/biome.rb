class Gef::Biome < ActiveRecord::Base
  has_many :gef_pame_records, class_name: 'Gef::PameRecord'
end
