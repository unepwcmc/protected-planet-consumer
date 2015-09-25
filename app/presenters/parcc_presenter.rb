module ParccPresenter
  def self.grouped_turnovers all_turnovers
    all_turnovers.each_with_object({}) { |turnover, groups|
      class_name = turnover.taxonomic_class.name

      groups[class_name] ||= {}
      groups[class_name][turnover.year] = turnover
    }
  end

  def self.grouped_vulnerability_assessments all_vulnerability_assessments
    all_vulnerability_assessments.each_with_object({}) { |vulnerability_assessment, groups|
      class_name = vulnerability_assessment.taxonomic_class.name

      groups[class_name] ||= vulnerability_assessment
    }.tap { |assessments|
      assessments[:total] = {
        vulnerable: assessments.values.map(&:count_vulnerable_species).inject(:+),
        total: assessments.values.map(&:count_total_species).inject(:+)
      }
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
