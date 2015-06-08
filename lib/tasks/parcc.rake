PROTECTED_AREAS_SOURCE = Rails.root.join('lib/data/parcc/turnover/Amphibian species turnover 2040 wt WDPAID.csv')
PROTECTED_AREAS_DEST   = Rails.root.join('lib/data/parcc/protected_areas.csv')

namespace :parcc do
  desc 'Import PARCC data'
  task import: :environment do
    ActiveRecord::Base.transaction do
      if ENV['DESTRUCTIVE']
        [
          Parcc::ProtectedArea,
          Parcc::Species,
          Parcc::SpeciesProtectedArea,
          Parcc::SpeciesTurnover,
          Parcc::TaxonomicClass,
          Parcc::TaxonomicOrder
        ].each(&:delete_all)
      end

      CSV.open(PROTECTED_AREAS_DEST, 'wb') do |dest|
        copy_first_8_columns = -> (row) { dest << row.first(8) }
        CSV.foreach(PROTECTED_AREAS_SOURCE, &copy_first_8_columns)
      end

      Parcc::Importers::ProtectedAreas.import

      Parcc::Importers::Species.import_taxonomies
      Parcc::Importers::Species.import_counts

      Parcc::Importers::Turnover.import
    end
  end
end
