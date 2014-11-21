class Gef::PameRecordController < ApplicationController

  def index
    @pame_assessments =  Gef::WdpaRecord.includes(:gef_pame_records).where('wdpa_id = ?', params[:wdpa_id])
    debugger
  end
end