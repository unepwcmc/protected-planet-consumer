class Gef::Api::AreasController < ApplicationController
  def index
    check_params = params.values.map{ |param| true if not param.blank? }

    if check_params.include? true
      debugger

      # areas = Gef::Area.where('gef_pmis_id = ?', gef_pmis_id).first.generate_api_data
    end
    render json: areas, status: 200
  end
end