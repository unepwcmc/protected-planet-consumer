class Parcc::Importers::Species::Taxonomies < Parcc::Importers::Base
  def initialize
    @species = {}
    @taxon_classes = {}
    @taxon_orders = {}
  end

  def import
    csv_reader(source_file_path).each do |record|
      next unless protected_area = fetch_protected_area(record[:wdpa_id])
      taxon_class = taxon_class(record[:species_taxon])
      taxon_order = taxon_order(record[:species_order], taxon_class)
      species = species(record, taxon_order)

      join_protected_area species, protected_area, record
    end
  end

  private

  def taxon_class class_name
    @taxon_classes[class_name] ||= Parcc::TaxonomicClass.find_or_create_by(name: class_name)
  end

  def taxon_order order_name, taxon_class
    @taxon_orders[order_name] ||= Parcc::TaxonomicOrder.find_or_create_by(
      name: order_name,
      taxonomic_class: taxon_class
    )
  end

  def species record, taxon_order
    species = species_props record

    Parcc::Species.create_with(
      species.merge(taxonomic_order: taxon_order)
    ).find_or_create_by(
      name: species[:name]
    )
  end

  def species_props record
    record.each_with_object({}) do |(key, value), dest|
      next unless conversion = SPECIES_CONVERSIONS[key]
      dest[conversion[:dest]] = conversion[:block].call(value)
    end
  end

  def join_protected_area species, protected_area, record
    Parcc::SpeciesProtectedArea.create(
      species: species,
      protected_area: protected_area,
      intersection_area: record[:species_wdpa_intersept_area_sum],
      overlap_percentage: record[:overlap_wdpa_percent]
    )
  end

  def source_file_path
    Rails.root.join('lib/data/parcc/species/cc_vulnerable_species.csv')
  end

  STR_TO_BOOL = -> (value) { value =~ /yes/i ? true : false }
  IDENTITY = -> (value) { value }

  SPECIES_CONVERSIONS = {
    sensitivity:      { dest: :sensitivity,   block: IDENTITY },
    adaptability:     { dest: :adaptability,  block: IDENTITY },
    exposure_2025:    { dest: :exposure_2025, block: IDENTITY },
    exposure_2055:    { dest: :exposure_2055, block: IDENTITY },
    species_iucn_cat: { dest: :iucn_cat,      block: IDENTITY },
    species_binomial: { dest: :name,          block: IDENTITY },
    cc_vulnerability: { dest: :cc_vulnerable, block: STR_TO_BOOL }
  }
end
