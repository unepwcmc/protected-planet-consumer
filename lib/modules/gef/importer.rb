class Gef::Importer
  def self.convert_to_hash filename: filename
    @filename = filename
    csv_table = read_csv
    keys = csv_table[0]
    csv_table.from(1).map {|value| Hash[keys.zip(value)] }
  end

  def self.find_fields protected_area
    gef_protected_area = {}
    protected_area.each do |k,v|
       model_column = GefColumnMatch.select(:model_columns).where(xls_columns: k)
       gef_protected_area.merge!(model_column.first['model_columns'].to_sym => v)
    end
    gef_protected_area
  end

  private

  def self.read_csv
    CSV.read(@filename)
  end
end
