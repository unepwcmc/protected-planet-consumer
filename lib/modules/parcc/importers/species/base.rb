require 'csv'

class Parcc::Importers::Species::Base
  def self.import
    instance = new
    instance.import
  end

  private

  def fetch_protected_area wdpa_id
    Parcc::ProtectedArea.find_by_wdpa_id wdpa_id
  end

  def source_file_path
    raise NotImplementedError, 'Define a source file for the specific importer'
  end

  def csv_reader
    @csv_reader ||= CSV.foreach(source_file_path, headers: true, header_converters: :symbol)
  end
end
