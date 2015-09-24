require 'csv'

class Parcc::Importers::Base
  def self.import
    instance = new
    instance.import
  end

  private

  def csv_reader file_path
    CSV.foreach(file_path, headers: true, header_converters: :symbol)
  end

  def source_file_path
    raise NotImplementedError, 'Define a source file for the specific importer'
  end

  def fetch_protected_area wdpa_id
    @pas ||= {}
    @pas[wdpa_id] ||= Parcc::ProtectedArea.find_by_wdpa_id(wdpa_id)
  end

  def fetch_taxonomic_class class_name
    @tc ||= {}
    @tc[class_name] ||= Parcc::TaxonomicClass.find_by_name(class_name)
  end
end
