require 'csv'

class Parcc::Importer::Species

  SPECIES_COLUMNS_MATCH = [:sensivity, :adaptability,
                           :exposure_2025, :exposure_2055, :cc_vulnerable]

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
      species_input = species_data csv_record: row
      Parcc::Species.create(species_input)
    end
  end

  def species_data csv_record: csv_record
    species_hash = {}
    csv_record.each do |k,v|
      species_hash[:k] = v if SPECIES_COLUMNS_MATCH.include? k
      species_hash[:iucn_cat] = v if k == :species_iucn_cat
      species_hash[:name] = v if k == :species_binomial
      if k == :cc_vulnerability
        species_hash[:cc_vulnerable] = v == 'yes' ? true : false
      elsif k == :species_order
        order_id = Parcc::TaxonomicOrder.where('name = ?', v).first.id
        species_hash[:parcc_taxonomic_order_id] = order_id
      end
    end
    species_hash
  end
end
