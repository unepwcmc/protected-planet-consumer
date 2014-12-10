class Gef::PameRecordController < ApplicationController

  def index
    @pame_assessments =  Gef::PameRecord.joins(:gef_wdpa_record, :gef_area)
                                        .select('*')
                                        .where('gef_wdpa_records.wdpa_id = ? AND gef_areas.gef_pmis_id = ?',
                                                params[:wdpa_id], params[:gef_pmis_id])
                                        .order('gef_pame_records.assessment_year ASC')
  end

  def show
    @assessment = Gef::PameRecord.select('*')
                                 .joins(:gef_wdpa_record, :gef_pame_name)
                                 .where('mett_original_uid = ? AND gef_wdpa_records.wdpa_id = ? ',
                                          params[:mett_original_uid],
                                          params[:wdpa_id])
  end
end