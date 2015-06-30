class Parcc::ProtectedAreasController < ApplicationController
  layout "parcc"

  def show
    @protected_area = Parcc::ProtectedArea
      .with_turnovers
      .find_by(wdpa_id: params[:id])

    @turnovers = grouped_turnovers(@protected_area.species_turnovers)
    @suitability_changes = grouped_suitability_changes(
      @protected_area.suitability_changes.with_changes
    )
  end

  def grouped_turnovers all_turnovers
    all_turnovers.each_with_object({}) { |turnover, groups|
      class_name = turnover.taxonomic_class.name

      groups[class_name] ||= {}
      groups[class_name][turnover.year] = turnover
    }
  end

  def grouped_suitability_changes all_suitability_changes
    all_suitability_changes.each_with_object({}) { |suitability_change, groups|
      species_name = suitability_change.species.name

      groups[species_name] ||= {}
      groups[species_name][suitability_change.year] = suitability_change.value
    }
  end
end
