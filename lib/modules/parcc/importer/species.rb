require 'csv'

class Parcc::Importer::Species
  def initialize filename: filename
    @filename = filename
    @csv_reader = CSV.read(@filename, headers: true)
  end

end
