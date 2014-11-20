require 'csv'

class Gef::Importer
  def initialize(filename: filename, bucket_name: bucket_name)
    @filename = filename
    @bucket_name = bucket_name
  end

  def import
    download
    gef_ids
    pas_list = convert_to_hash
    pas_list.each do |pa|
      pa_converted = find_fields pa
      gef_area_id = Gef::Area.where('gef_pmis_id = ?', pa_converted[:gef_pmis_id].to_i).first[:id]
      pa_converted[:gef_area_id] = gef_area_id
      Gef::PameRecord.create(pa_converted.except(:gef_pmis_id, :wdpa_id))
      Gef::WdpaRecord.create(wdpa_id: pa_converted[:wdpa_id], gef_area_id: gef_area_id)
    end
  end

  def gef_ids
    gef_id_column = gef_pmis_id_column
    gef_id_column.each do |gef_id|
      Gef::Area.create(gef_pmis_id: gef_id)
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

  def convert_to_hash
    csv_table = read_csv
    keys = csv_table[0]
    csv_table.from(1).map { |value| Hash[keys.zip(value)] }
  end

  private

  def download
    s3 = S3.new(@bucket_name)
    s3.download_from_bucket(filename: @filename)
  end

  def read_csv
    CSV.read(@filename)
  end

  def gef_pmis_id_column
    column_data = []
    CSV.foreach(@filename, headers: true) {|row| column_data << row[0]}
    column_data
  end
end
