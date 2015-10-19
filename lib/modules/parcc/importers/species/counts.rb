class Parcc::Importers::Species::Counts < Parcc::Importers::Base
  def import
    csv_reader(source_file_path).each do |record|
      @protected_area = fetch_protected_area(record[:wdpa_id])
      next unless @protected_area

      @taxonomic_class = fetch_taxonomic_class(record[:taxon_class])
      next unless @taxonomic_class

      add_counts record
      add_relation record
    end
  end

  private

  def add_relation record
    Parcc::TaxonomicClassProtectedArea.create({
      parcc_protected_area_id: @protected_area.id,
      parcc_taxonomic_class_id: @taxonomic_class.id,
      count_total_species: record[:total_species],
      count_vulnerable_species: record[:vulnerable_species]
    })
  end

  def add_counts record
    @protected_area.count_total_species += record[:total_species]
    @protected_area.count_vulnerable_species += record[:vulnerable_species]
    @protected_area.percentage_vulnerable_species = (
      @protected_area.count_vulnerable_species.to_f / @protected_area.count_total_species
    ) * 100

    @protected_area.save
  end

  def source_file_path
    Rails.root.join('lib/data/parcc/species/taxonomic_class_protected_areas.csv')
  end
end
