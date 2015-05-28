class Gef::Api::AreasController < ApplicationController
  def index
    check_params = params.values.map{ |param| true if not param.blank? }

    if check_params.include? true
      areas = Gef::Api::Area.area_finder params: params
    end
    render json: areas, status: 200
  end
end