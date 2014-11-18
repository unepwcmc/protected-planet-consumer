require 'csv'

class Parcc::Importer::Species

  SPECIES_COLUMNS_MATCH = [:sensivity, :adaptability,
                           :exposure_2025, :exposure_2055,
                           :cc_vulnerable]

  def initialize filename: filename
    @filename = filename
    @csv_reader = CSV.read(@filename, headers: true, header_converters: :symbol)
  end

  def import_taxo
    @csv_reader.each do |record|
      create_class csv_record: record
      create_order csv_record: record
      create_species csv_record: record
      join_protected_area csv_record: record
    end
  end

  def create_class csv_record: csv_record
    Parcc::TaxonomicClass.create(name: csv_record[:species_taxon])
  end

  def create_order csv_record: csv_record
    class_name = csv_record[:species_taxon]
    class_id = Parcc::TaxonomicClass.where('name = ?', class_name).first.id
    Parcc::TaxonomicOrder.create(name: csv_record[:species_order], parcc_taxonomic_class_id: class_id)
  end

  def create_species csv_record: csv_record
    species_hash = {}
    csv_record.each do |k,v|
      species_hash[k] = v if SPECIES_COLUMNS_MATCH.include? k
      species_hash[:iucn_cat] = v if k == :species_iucn_cat
      species_hash[:name] = v if k == :species_binomial
      if k == :cc_vulnerability
        species_hash[:cc_vulnerable] = v == 'yes' ? true : false
      elsif k == :species_order
        order_id = Parcc::TaxonomicOrder.where('name = ?', v).first.id
        species_hash[:parcc_taxonomic_order_id] = order_id
      end
    end
    Parcc::Species.create(species_hash)
  end

  def join_protected_area csv_record: csv_record
    protected_area = protected_area_query csv_record: csv_record
    species = Parcc::Species.where('name = ?', csv_record[:species_binomial]).first
    Parcc::SpeciesProtectedArea.create(parcc_species_id: species.id,
                                       parcc_protected_areas_id: protected_area.id,
                                       intersection_area: csv_record[:species_wdpa_intersept_area_sum],
                                       overlap_percentage: csv_record[:overlap_wdpa_percent])
  end

  def protected_area_query csv_record: csv_record
    Parcc::ProtectedArea.where('wdpa_id = ?', csv_record[:wdpa_id])
                        .first_or_create(name: csv_record[:wdpa_name],
                                         iso_3: csv_record[:wdpa_country],
                                         iucn_cat: csv_record[:wdpa_iucn_cat])
  end
end
