class Parcc::Api::ProtectedAreasController < ApplicationController
  def index
    render json: Parcc::ProtectedArea.for_api
  end

  def show
    render json: protected_area.for_api(show_params)
  end

  def vulnerability
    render(
      json: Parcc::SpeciesProtectedArea.
        vulnerability_table_for(protected_area.id, params[:taxonomic_class]),
        root: false
    )
  end

  def suitability_changes
    render(
      json: ParccPresenter.grouped_suitability_changes(
        protected_area.suitability_changes.with_changes
      )
    )
  end

  private

  MESSAGE_404 = -> id { "Can't find PARCC Protected Area with WDPA ID #{id}" }
  def protected_area
    Parcc::ProtectedArea.find_by_wdpa_id(wdpa_id) or raise_404 MESSAGE_404[wdpa_id]
  end

  def wdpa_id
    params[:id]
  end

  def show_params
    params.slice(:with_species).symbolize_keys
  end
end
