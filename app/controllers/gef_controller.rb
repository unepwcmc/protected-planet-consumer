class GefController < ApplicationController
  layout 'gef'
  def index
    if params[:description]
      areas = Gef::Area.where(gef_pmis_id: params[:description]).first
      if areas
        redirect_to gef_area_path(gef_pmis_id: areas.gef_pmis_id)
      else
        redirect_to gef_not_found_path
      end
    end
  end
end
