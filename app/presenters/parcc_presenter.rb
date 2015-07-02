module ParccPresenter
  def self.grouped_turnovers all_turnovers
    all_turnovers.each_with_object({}) { |turnover, groups|
      class_name = turnover.taxonomic_class.name

      groups[class_name] ||= {}
      groups[class_name][turnover.year] = turnover
    }
  end

  def self.grouped_suitability_changes all_suitability_changes, opts={with_model: false}
    all_suitability_changes.each_with_object({}) { |suitability_change, groups|
      key = suitability_change.species
      key = key.name unless opts[:with_model]

      groups[key] ||= {}
      groups[key][suitability_change.year] = suitability_change.value
    }
  end
end
