class Parcc::Importers::Species::Counts < Parcc::Importers::Species::Base

  def import
    csv_reader.each do |record|
      protected_area = fetch_protected_area(record[:WDPA_ID])

      add_counts_to_pa(protected_area, {
        count_total_species: record[:COUNT_TOTAL_SPECIES],
        percentage_vulnerable_species: record[:PERCENT_CC_VULNERABLE_SPECIES],
        count_vulnerable_species: record[:COUNT_CC_VULNERABLE_SPECIES]
      })
    end
  end

  private

  def add_counts_to_pa protected_area, counts
    protected_area.update_attributes(counts)
  end

  def source_file_path
    Rails.root.join('lib/data/parcc/species/wdpa_species_count.csv')
  end
end
