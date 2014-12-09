class Gef::Area < ActiveRecord::Base
  has_many :gef_wdpa_records, class_name: 'Gef::WdpaRecord', foreign_key: :gef_area_id
  has_many :gef_pame_records, class_name: 'Gef::PameRecord', foreign_key: :gef_area_id
  validates_uniqueness_of :gef_pmis_id

  def generate_data
    gef_pmis_id = self.gef_pmis_id
    wdpa_data = Gef::WdpaRecord.wdpa_name(gef_pmis_id: gef_pmis_id)
    wdpa_data.map { |pa| merge_data protected_area: pa }
    wdpa_data
  end

  private

  def merge_data protected_area: protected_area
    protected_area.merge!({ gef_pmis_id: gef_pmis_id, name: name })
    protected_area[:wdpa_name] = name if not protected_area[:wdpa_name]
  end
end
