class Gef::AreaController < ApplicationController
  before_filter :gef_area

  def gef_area
    @gef_area = Gef::Area.where('gef_pmis_id = ?', params[:gef_pmis_id]).first
  end

  def show
    @protected_areas = @gef_area.generate_data.sort_by  { |h| h[:wdpa_name] }
  end

  
  respond_to do |format|
    format.html # show.html.erb
  end
end