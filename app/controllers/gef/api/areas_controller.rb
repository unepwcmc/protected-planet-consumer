class Gef::Api::AreasController < ApplicationController
  def index
    if gef_pmis_id = params[:id]
      areas = Gef::Area.where('gef_pmis_id = ?', gef_pmis_id).first.generate_api_data
    end
    render json: areas, status: 200
  end
end