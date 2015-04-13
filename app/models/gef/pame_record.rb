class Gef::PameRecord < ActiveRecord::Base
  has_many :gef_wdpa_records, class_name: 'Gef::WdpaRecord', through: :gef_pame_record_wdpa_records
  has_many :gef_pame_record_wdpa_records, class_name: 'Gef::PameRecordWdpaRecord', foreign_key: :gef_pame_record_id
  belongs_to :gef_area, class_name: 'Gef::Area', foreign_key: :gef_area_id
  belongs_to :gef_pame_name, class_name: 'Gef::PameName', foreign_key: :gef_pame_name_id
  belongs_to :gef_budget_type, class_name: 'Gef::BudgetType', foreign_key: :budget_recurrent_type_id
  belongs_to :gef_budget_type, class_name: 'Gef::BudgetType', foreign_key: :budget_project_type_id
  belongs_to :primary_biome, class_name: 'Gef::Biome', foreign_key: :primary_biome_id
  belongs_to :secondary_biome, class_name: 'Gef::Biome', foreign_key: :secondary_biome_id
  belongs_to :terciary_biome, class_name: 'Gef::Biome', foreign_key: :terciary_biome_id
  belongs_to :quaternary_biome, class_name: 'Gef::Biome', foreign_key: :quaternary_biome_id

  def self.data_list mett_original_uid: mett_original_uid, wdpa_id: wdpa_id

    dirty_sql = """
        SELECT a.*, r.*, brt.budget_recurrent_type, bpt.budget_project_type, n.*, wr.*
          FROM gef_pame_records r
          JOIN gef_wdpa_records wr ON r.gef_wdpa_record_id = wr.id
          JOIN gef_areas a ON r.gef_area_id = a.id
          JOIN gef_pame_names n ON r.gef_pame_name_id = n.id
          JOIN
            (SELECT id, name AS budget_recurrent_type FROM gef_budget_types) brt
             ON budget_recurrent_type_id = brt.id
          JOIN
            (SELECT id, name AS budget_project_type FROM gef_budget_types) bpt
            ON budget_project_type_id = bpt.id
          WHERE mett_original_uid = ? AND wr.wdpa_id = ?
        """.squish


    query = ActiveRecord::Base.send(:sanitize_sql_array, [dirty_sql, mett_original_uid, wdpa_id])

    result = ActiveRecord::Base.connection.execute(query).first

    result.symbolize_keys!
    result.except!(:id, :created_at, :updated_at, :gef_wdpa_record_id, :gef_area_id,
                   :budget_recurrent_type_id, :budget_project_type_id, :gef_pame_name_id,
                   :wdpa_exists)

    result.each{ |k,v|  result[k] = v.to_i if v.to_i.to_s == v }

    result.each { |k, v| result[k] = '' if v.nil? }
  end
end