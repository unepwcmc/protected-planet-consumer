class Parcc::ProtectedAreasController < ApplicationController
  layout "parcc"

  before_filter :load_protected_area

  def show
    @turnovers = ParccPresenter.grouped_turnovers(@protected_area.species_turnovers)
    @suitability_changes = ParccPresenter.grouped_suitability_changes(
      @protected_area.suitability_changes.with_changes
    )
  end

  end

  private

  def load_protected_area
    @protected_area = Parcc::ProtectedArea
      .with_turnovers
      .find_by(wdpa_id: params[:id])
  end
end
