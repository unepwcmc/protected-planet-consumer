require 'csv'

class Gef::Importer
  def initialize(filename: filename, bucket_name: bucket_name)
    @bucket_name = bucket_name
    @filename = filename
    @consumer = Gef::Consumer.new
  end

  def import
    download
    csv_table = CSV.read(@filename, headers: true)
    csv_table.each do |pa|
      pa_converted = find_fields pa

      Gef::Area.find_or_create_by(gef_pmis_id: pa_converted[:gef_pmis_id].to_i)
      gef_area_id = Gef::Area.where('gef_pmis_id = ?', pa_converted[:gef_pmis_id].to_i).first[:id]

      budget_recurrent = create_budget_type(budget: pa_converted[:budget_recurrent], category: 'recurrent')
      budget_project = create_budget_type(budget: pa_converted[:budget_project], category: 'project')

      Gef::PameName.find_or_create_by(name: pa_converted[:pa_name_mett])
      gef_pame_name_id = Gef::PameName.where('name = ?', pa_converted[:pa_name_mett]).first[:id]

      Gef::WdpaRecord.find_or_create_by(wdpa_id: pa_converted[:wdpa_id], gef_area_id: gef_area_id, gef_pame_name_id: gef_pame_name_id)
      wdpa_record_id = Gef::WdpaRecord.where('wdpa_id = ?', pa_converted[:wdpa_id].to_i).first[:id]

      converted = pa_converted.except(:gef_pmis_id, :wdpa_id, :pa_name_mett, :budget_recurrent, :budget_project)
      ids = { gef_wdpa_record_id: wdpa_record_id, gef_area_id: gef_area_id, gef_pame_name_id: gef_pame_name_id }
      pame_record_params = [converted, ids, budget_recurrent, budget_project ]
      pame_record = pame_record_params.inject(&:merge)

      Gef::PameRecord.create(pame_record)

    end
    wdpa_ids_list = Gef::WdpaRecord.select(:wdpa_id).group(:wdpa_id)
    wdpa_ids_list.each { |pa| @consumer.api_data(wdpa_id: pa.wdpa_id) }
  end


  def find_fields(protected_area)
    gef_protected_area = {}
    protected_area.each do |column, value|
      model_column = Gef::ColumnMatch.select(:model_columns).where(xls_columns: column)
      unless model_column == []
        gef_protected_area.merge!(model_column.first['model_columns'].to_sym => value)
      end
    end
    gef_protected_area
  end

  private

  def create_budget_type(budget: budget, category: category)
    budget_hash = budget_selector(budget: budget)
    Gef::BudgetType.find_or_create_by(name: budget_hash[:type])
    type_id = Gef::BudgetType.where('name = ?', budget_hash[:type]).first[:id]
    budget_selected = {}
    budget_selected["budget_#{category}_type_id".to_sym] = type_id
    budget_selected["budget_#{category}_value".to_sym] = budget_hash[:value] if budget_hash.has_key?(:value)
    budget_selected
  end

  def download
    s3 = S3.new(@bucket_name)
    s3.download_from_bucket(filename: @filename)
  end

  def budget_selector budget: budget
    if budget.blank?
      { type: 'Not Given' }
    elsif budget.to_i.to_s == budget
      { type: 'Given', value: budget }
    else
      { type: budget }
    end
  end
end
