class Gef::Area < ActiveRecord::Base
  has_many :gef_pame_records, class_name: 'Gef::PameRecord', foreign_key: :gef_area_id
  validates_uniqueness_of :gef_pmis_id



  def generate_api_data
    wdpa_data = query_wdpa gef_pmis_id: self.gef_pmis_id
    api_data = []
    wdpa_data.each do |protected_area|
      assessments_data = assessments(wdpa_id: protected_area[:wdpa_id], gef_pmis_id: gef_pmis_id)
      protected_area[:assessments] = assessments_data
      api_data << protected_area
    end
    api_data
  end


  private

  def query_wdpa gef_pmis_id: gef_pmis_id
    wdpa_data = Gef::WdpaRecord.wdpa_name(gef_pmis_id: gef_pmis_id)
    wdpa_data.map { |pa| pa.merge!({ gef_pmis_id: gef_pmis_id })}
  end

  def assessments wdpa_id: wdpa_id, gef_pmis_id: gef_pmis_id
    pame_records = pame_records (wdpa_id: wdpa_id, gef_pmis_id: gef_pmis_id)
    pame_hash = []
    pame_records.each do |record|
      pame_hash << data_list(mett_original_uid: record[:mett_original_uid],
                             wdpa_id: wdpa_id).except(:gef_pmis_id, :wdpa_id)

    end
    pame_hash
  end

  def data_list mett_original_uid: mett_original_uid, wdpa_id: wdpa_id
    Gef::PameRecord.data_list(mett_original_uid: mett_original_uid,
                                    wdpa_id: wdpa_id).delete_if { |k, v| v.nil? }
  end

  def pame_records wdpa_id: wdpa_id, gef_pmis_id: gef_pmis_id
    pame_records = Gef::PameRecord
                .select(:mett_original_uid)
                .joins(:gef_wdpa_record, :gef_area)
                .where('gef_wdpa_records.wdpa_id = ? AND gef_areas.gef_pmis_id = ?',
                        wdpa_id, gef_pmis_id)
                .order('mett_original_uid ASC')
  end
end
