class Gef::Api::AreaController < ApplicationController
  def index
    areas = Gef::Area.all
    if gef_pmis_id = params[:id]
      areas = areas.where('gef_pmis_id = ?', gef_pmis_id).first.generate_data
    end
    render json: areas, status: 200
  end
end