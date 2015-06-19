class Parcc::ProtectedAreasController < ApplicationController
  layout "parcc"

  def show
    @protected_area = Parcc::ProtectedArea.find_by(wdpa_id: params[:id])
  end
end
