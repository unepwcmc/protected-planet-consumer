module Api
  class GefController < ApplicationController
    def index
      gef_pas = GefProtectedArea.all
      if pmis_id = params[:pmis_id]
        gef_pas = gef_pas.where(gef_pmis_id: pmis_id)
      end

      render json: gef_pas, status: 200
    end
  end
end
