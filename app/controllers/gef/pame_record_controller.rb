class Gef::PameRecordController < ApplicationController

  def index
    @pame_assessments =  Gef::WdpaRecord.includes(:gef_pame_records, :gef_area).where('wdpa_id = ?', params[:wdpa_id])
  end

  def show

  end
end