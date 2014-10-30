module Api
  class GefController < ApplicationController
    def index
      gef_pas = Gef::ProtectedArea.all
      if pmis_id = params[:pmis_id]
        pas_array = []
        all_pas = gef_pas.where(gef_pmis_id: pmis_id)
        all_pas.each do |pa|
          pas_array << pa.generate_data
        end
        gef_pas = pas_array
      end
      render json: gef_pas, status: 200
    end
  end
end
