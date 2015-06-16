class Parcc::Importers::Species::Counts < Parcc::Importers::Base
  def import
    csv_reader(source_file_path).each do |record|
      protected_area = fetch_protected_area(record[:wdpa_id])
      next unless protected_area

      add_counts_to_pa(protected_area, {
        count_total_species: record[:count_total_species],
        percentage_vulnerable_species: record[:percent_cc_vulnerable_species],
        count_vulnerable_species: record[:count_cc_vulnerable_species]
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
