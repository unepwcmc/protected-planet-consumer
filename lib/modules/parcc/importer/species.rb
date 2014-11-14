require 'csv'

class Parcc::Importer::Species

  def initialize filename: filename
    @filename = filename
    @csv_reader = CSV.read(@filename, headers: true, header_converters: :symbol)
  end

  def import_taxo
    @csv_reader.each do |row|
      taxo_class_name = row[:species_taxon]
      taxo_order_name = row[:species_order]
      Parcc::TaxonomicClass.create(name: taxo_class_name)
      taxo_class_id = Parcc::TaxonomicClass.where('name = ?', taxo_class_name).first.id
      Parcc::TaxonomicOrder.create(name: taxo_order_name, parcc_taxonomic_class_id: taxo_class_id)
    end
  end
end
