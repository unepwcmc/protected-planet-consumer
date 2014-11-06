module Api
  class GefController < ApplicationController
    def show
      all_pas = Gef::Area.select('*').joins(:gef_wdpa_records).where(gef_pmis_id: params[:gef_pmis_id])
      pas_array = []
      all_pas.each do |pa|
        pas_array << pa.generate_data
      end
      puts pas_array
      gef_pas = pas_array
      render json: gef_pas, status: 200
    end
  end
end
