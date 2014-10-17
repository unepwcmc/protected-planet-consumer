class Gef::Importer

  def self.import filename: filename
    @filename = filename
    pas_list = convert_to_hash(filename: filename)
    pas_list.each do |pa|
      pa_converted = find_fields pa
      GefProtectedArea.create(pa_converted)
    end
  end

  def self.find_fields protected_area
    gef_protected_area = {}
    protected_area.each do |column,value|
       model_column = GefColumnMatch.select(:model_columns).where(xls_columns: column)
       gef_protected_area.merge!(model_column.first['model_columns'].to_sym => value)
    end
    gef_protected_area
  end

  private

  def self.convert_to_hash filename: filename
    @filename = filename
    csv_table = read_csv
    keys = csv_table[0]
    csv_table.from(1).map {|value| Hash[keys.zip(value)] }
  end

  def self.read_csv
    CSV.read(@filename)
  end

end
