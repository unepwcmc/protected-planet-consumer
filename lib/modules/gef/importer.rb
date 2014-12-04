require 'csv'

class Gef::Importer
  def initialize(filename: filename, bucket_name: bucket_name)
    @bucket_name = bucket_name
    @filename = filename
  end

  def import
    download
    csv_table = CSV.read(@filename, headers: true)
    csv_table.each do |pa|
      pa_converted = find_fields pa
      Gef::Area.find_or_create_by(gef_pmis_id: pa_converted[:gef_pmis_id].to_i, name: pa_converted[:pa_name_mett])
      gef_area_id = Gef::Area.where('gef_pmis_id = ?', pa_converted[:gef_pmis_id].to_i).first[:id]
      Gef::WdpaRecord.create(wdpa_id: pa_converted[:wdpa_id], gef_area_id: gef_area_id)
      wdpa_record_id = Gef::WdpaRecord.where('wdpa_id = ?', pa_converted[:wdpa_id].to_i).first[:id]
      pa_converted.except!(:gef_pmis_id, :wdpa_id)
      Gef::PameRecord.create(pa_converted.merge(gef_wdpa_record_id: wdpa_record_id))
    end
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

  def download
    s3 = S3.new(@bucket_name)
    s3.download_from_bucket(filename: @filename)
  end
end
