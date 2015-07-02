module Parcc::Downloads::Generators::SuitabilityChanges
  BASE_PATH = Rails.root.join('tmp/downloads/')

  HEADERS = ['Name', 'Taxonomic Order', 'Taxonomic Class', 'By 2010-2039', 'By 2040-2069', 'By 2070-2099']

  def self.generate protected_area
    filename = "#{protected_area.wdpa_id}_suitability_changes.csv"
    full_path = BASE_PATH.join(filename)

    CSV.open(full_path, 'wb') do |csv|
      csv << HEADERS

      grouped_changes(protected_area).each { |species, suitability_changes|
        csv << collect_values(species, suitability_changes)
      }
    end

    full_path
  end

  def self.collect_values species, suitability_changes
    [
      species.name,
      species.taxonomic_order.name,
      species.taxonomic_class.name,
      suitability_changes[2040],
      suitability_changes[2070],
      suitability_changes[2100]
    ]
  end

  def self.grouped_changes protected_area
    ParccPresenter.grouped_suitability_changes(
      protected_area.suitability_changes.with_changes,
      with_model: true
    )
  end
end
