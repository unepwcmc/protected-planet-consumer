class Gef::PameRecordController < ApplicationController

  def index
    @pame_assessments =  Gef::WdpaRecord.includes(:gef_pame_records, :gef_area).where('wdpa_id = ?', params[:wdpa_id]).order('gef_pame_records.assessment_year ASC')
  end

  def show
    @assessment = Gef::PameRecord.includes(:gef_wdpa_record).where('mett_original_uid = ?', params[:mett_original_uid])
  end
end