class Parcc::Api::ProtectedAreasController < ApplicationController
  def index
    render json: Parcc::ProtectedArea.for_api
  end

  def show
    render json: protected_area.for_api
  end

  private

  MESSAGE_404 = -> id { "Can't find PARCC Protected Area with WDPA ID #{id}" }

  def protected_area
    Parcc::ProtectedArea.find_by_wdpa_id(wdpa_id) or raise_404 MESSAGE_404[wdpa_id]
  end

  def wdpa_id
    params[:id]
  end
end
