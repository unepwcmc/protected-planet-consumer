require 'csv'

class Gef::Importer
  def initialize(filename: filename, bucket_name: bucket_name)
    @filename = filename
    @bucket_name = bucket_name
  end

  def import
    download
    pas_list = convert_to_hash
    pas_list.each do |pa|
      pa_converted = find_fields pa
      GefProtectedArea.create(pa_converted)
    end
  end

  def download
    s3 = S3.new(@bucket_name)
    s3.download_from_bucket(filename: @filename)
  end

  def find_fields(protected_area)
    gef_protected_area = {}
    protected_area.each do |column, value|
      model_column = GefColumnMatch.select(:model_columns).where(xls_columns: column)
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

  def read_csv
    CSV.read(@filename)
  end
end
