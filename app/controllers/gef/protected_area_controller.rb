class Gef::WdpaRecordController < ApplicationController
  def index
  @protected_areas = Gef::WdpaRecord.all
    if params[:gef_pmis_id]
      @all_protected_areas = Gef::WdpaRecord.where(gef_pmis_id: params[:gef_pmis_id])
      @protected_areas = []
      @all_protected_areas.each do |pa|
        @protected_areas << pa.generate_data
      end 
    end
  end

  respond_to do |format|
    format.html # index.html.erb
  end
  
end