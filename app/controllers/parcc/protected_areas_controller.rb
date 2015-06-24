class Parcc::ProtectedAreasController < ApplicationController
  layout "parcc"

  def show
    @protected_area = Parcc::ProtectedArea
      .with_turnovers
      .find_by(wdpa_id: params[:id])

    @turnovers = grouped_turnovers(@protected_area.species_turnovers)
  end

  def grouped_turnovers all_turnovers
    all_turnovers.each_with_object({}) { |turnover, groups|
      class_name = turnover.taxonomic_class.name

      groups[class_name] ||= {}
      groups[class_name][turnover.year] = turnover
    }
  end
end
