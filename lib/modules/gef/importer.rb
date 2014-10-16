class Gef::Importer
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
