class Parcc::ProtectedAreasController < ApplicationController
  DEFAULT_TAXONOMIC_CLASS = Parcc::Import.configuration["default_taxonomic_class"]

  layout "parcc"
  before_filter :load_protected_area

  def show
    load_suitability_changes DEFAULT_TAXONOMIC_CLASS

    @turnovers = ParccPresenter.grouped_turnovers(@protected_area.species_turnovers)
    @vulnerability_assessments = ParccPresenter.grouped_vulnerability_assessments(@protected_area.taxonomic_class_protected_areas)
    @species_protected_areas = Parcc::SpeciesProtectedArea.vulnerability_table_for(
      @protected_area.id, DEFAULT_TAXONOMIC_CLASS
    )
  end

  def vulnerability_table
    @species_protected_areas = Parcc::SpeciesProtectedArea.vulnerability_table_for(
      @protected_area.id, params[:taxonomic_class]
    )

    render "parcc/protected_areas/_vulnerability_table", layout: false
  end

  def suitability_changes_table
    load_suitability_changes params[:taxonomic_class]
    render "parcc/protected_areas/_suitability_table", layout: false
  end

  def download
    send_file Parcc::Downloads.generate(@protected_area)
  end

  private

  def load_protected_area
    @protected_area = Parcc::ProtectedArea
      .with_turnovers
      .find_by(wdpa_id: params[:id])
  end

  def load_suitability_changes taxonomic_class=nil
    suitability_scope = @protected_area.suitability_changes.with_changes
    suitability_scope = suitability_scope.with_taxonomic_class(taxonomic_class) if taxonomic_class.present?

    @suitability_changes = ParccPresenter.grouped_suitability_changes(
      suitability_scope
    )
  end
end
