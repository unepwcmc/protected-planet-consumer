require 'csv'

class Parcc::Importer::Species
  IDENTITY = -> (value) { value }
  SPECIAL_COLUMNS = {
    sensivity:        { dest: :sensivity,     block: IDENTITY },
    adaptability:     { dest: :adaptability,  block: IDENTITY },
    exposure_2025:    { dest: :exposure_2025, block: IDENTITY },
    exposure_2055:    { dest: :exposure_2055, block: IDENTITY },
    cc_vulnerable:    { dest: :cc_vulnerable, block: IDENTITY },
    species_iucn_cat: { dest: :iucn_cat,      block: IDENTITY },
    species_binomial: { dest: :name,          block: IDENTITY },
    cc_vulnerability: {
      dest: :cc_vulnerable,
      block: -> (value) { value == 'yes' ? true : false }
    },
    species_order: {
      dest: :parcc_taxonomic_order_id,
      block: -> (value) { Parcc::TaxonomicOrder.where(name: value).first.id }
    }
  }

  def initialize filename: filename
    @filename = filename
    @csv_reader = CSV.foreach(@filename, headers: true, header_converters: :symbol)
  end

  def import_taxo
    @csv_reader.each do |record|
      create_class record
      create_order record
      create_species record
      join_protected_area record
    end
  end

  private

  def create_class csv_record
    Parcc::TaxonomicClass.create(name: csv_record[:species_taxon])
  end

  def create_order csv_record
    class_name = csv_record[:species_taxon]
    class_id = Parcc::TaxonomicClass.where(name: class_name).first.id

    Parcc::TaxonomicOrder.create(
      name: csv_record[:species_order],
      parcc_taxonomic_class_id: class_id
    )
  end

  def create_species csv_record
    species = csv_record.each_with_object({}) do |(key, value), dest|
      next unless conversion = SPECIAL_COLUMNS[key]
      dest[conversion[:dest]] = conversion[:block].call(value)
    end

    Parcc::Species.create(species)
  end

  def join_protected_area csv_record
    protected_area = protected_area_query csv_record
    species = Parcc::Species.where(name: csv_record[:species_binomial]).first

    Parcc::SpeciesProtectedArea.create(
      parcc_species_id: species.id,
      parcc_protected_areas_id: protected_area.id,
      intersection_area: csv_record[:species_wdpa_intersept_area_sum],
      overlap_percentage: csv_record[:overlap_wdpa_percent]
    )
  end

  def protected_area_query csv_record
    Parcc::ProtectedArea.where(wdpa_id: csv_record[:wdpa_id]).first_or_create(
      name: csv_record[:wdpa_name],
      iso_3: csv_record[:wdpa_country],
      iucn_cat: csv_record[:wdpa_iucn_cat]
    )
  end
end
