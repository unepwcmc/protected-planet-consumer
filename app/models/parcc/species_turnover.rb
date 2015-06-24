class Parcc::SpeciesTurnover < ActiveRecord::Base
  belongs_to :protected_area, class_name: 'Parcc::ProtectedArea', foreign_key: :parcc_protected_area_id
  belongs_to :taxonomic_class, class_name: 'Parcc::TaxonomicClass', foreign_key: :taxonomic_class_id

  def percentage(stat, round_to=1)
    (send(stat)*100).round(round_to)
  end
end
