class Gef::PameRecordsController < GefController

  def index
    @pame_assessments =  Gef::PameRecord.joins(:gef_wdpa_records, :gef_area)
                                        .where(gef_wdpa_records: {wdpa_id: params[:wdpa_record_wdpa_id]},
                                               gef_areas: {gef_pmis_id: params[:area_gef_pmis_id] })
                                        .order('gef_pame_records.assessment_year ASC')
  end

  def show
    @assessment = Gef::PameRecord.data_list(mett_original_uid: params[:mett_original_uid],
                                            wdpa_id: params[:wdpa_record_wdpa_id]).delete_if { |k, v| v == '' }

  end
end