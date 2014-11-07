class Gef::WdpaRecordController < ApplicationController
  before_filter :gef_area

  def gef_area
    @gef_area = Gef::Area.where('gef_pmis_id = ?', params[:gef_pmis_id]).first
  end

  def index
  @all_protected_areas = @gef_area.gef_wdpa_records
  @protected_areas = []
    @all_protected_areas.each do |pa|
      @protected_areas << pa.generate_data
    end 
  end

  def show

  end
  
  respond_to do |format|
    format.html # index.html.erb
  end
end
