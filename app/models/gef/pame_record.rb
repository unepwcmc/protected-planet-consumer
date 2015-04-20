class Gef::PameRecord < ActiveRecord::Base
  has_many :gef_wdpa_records, class_name: 'Gef::WdpaRecord', through: :gef_pame_record_wdpa_records
  has_many :gef_pame_record_wdpa_records, class_name: 'Gef::PameRecordWdpaRecord', foreign_key: :gef_pame_record_id
  belongs_to :gef_area, class_name: 'Gef::Area', foreign_key: :gef_area_id
  belongs_to :gef_pame_name, class_name: 'Gef::PameName', foreign_key: :gef_pame_name_id
  belongs_to :budget_recurrent_type, class_name: 'Gef::BudgetType', foreign_key: :budget_recurrent_type_id
  belongs_to :budget_project_type, class_name: 'Gef::BudgetType', foreign_key: :budget_project_type_id
  belongs_to :primary_biome, class_name: 'Gef::Biome', foreign_key: :primary_biome_id
  belongs_to :secondary_biome, class_name: 'Gef::Biome', foreign_key: :secondary_biome_id
  belongs_to :tertiary_biome, class_name: 'Gef::Biome', foreign_key: :tertiary_biome_id
  belongs_to :quaternary_biome, class_name: 'Gef::Biome', foreign_key: :quaternary_biome_id

  def self.data_list mett_original_uid: mett_original_uid, wdpa_id: wdpa_id

    tables = [:gef_area, :gef_pame_name, :gef_wdpa_records, :budget_recurrent_type, :primary_biome,
              :secondary_biome, :tertiary_biome, :quaternary_biome, :budget_recurrent_type,
              :budget_project_type]

    area = area_query(mett_original_uid: mett_original_uid, wdpa_id: wdpa_id)

    result = area.first.attributes.symbolize_keys!

    tables.each do |table|
      if table.to_s == 'gef_wdpa_records'
        result.merge!(wdpa_records(area: area))
      elsif table.to_s == 'gef_area'
        result.merge!(area.first.send(table).attributes.symbolize_keys)
      else
        values = change_column_name(area: area, table: table)
        other_values = { table =>  values}
        result.merge!( other_values )
      end
    end

    result.except!(:gef_wdpa_record_id, :gef_area_id, :id,
                   :budget_recurrent_type_id, :budget_project_type_id, :gef_pame_name_id,
                   :wdpa_exists, :primary_biome_id, :secondary_biome_id, :tertiary_biome_id,
                   :quaternary_biome_id, :marine)

    result.each{ |k,v|  result[k] = v.to_i if v.to_i.to_s == v }

    result.each { |k, v| result[k] = '' if v.nil? }
  end

  private

  def self.area_query mett_original_uid: mett_original_uid, wdpa_id: wdpa_id
    Gef::PameRecord.joins(:gef_wdpa_records)
              .where(mett_original_uid: mett_original_uid, gef_wdpa_records: {wdpa_id: wdpa_id})
  end

  def self.wdpa_records area: area
    area.first.gef_wdpa_records.first.attributes.symbolize_keys
  end

  def self.change_column_name area: area, table: table
    area.first.send(table).attributes.symbolize_keys[:name] if area.first.send(table)
  end
end