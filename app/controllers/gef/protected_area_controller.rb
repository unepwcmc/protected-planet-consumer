class Gef::ProtectedAreaController < ApplicationController
  def index
  @protected_areas = Gef::ProtectedArea.all
    if params[:gef_pmis_id]
      @all_protected_areas = Gef::ProtectedArea.where(gef_pmis_id: params[:gef_pmis_id])
      @protected_areas = []
      @all_protected_areas.each do |pa|
        @protected_areas << pa.generate_data
      end 
      debugger   
    end
  end

  respond_to do |format|
    format.html # index.html.erb
  end
  
end