class GefController < ApplicationController
  def index
    if params[:description]
      areas = Gef::Area.where(gef_pmis_id: params[:description]).first
      redirect_to area_wdpa_records_path(gef_pmis_id: areas.gef_pmis_id)
    end
  end
end
