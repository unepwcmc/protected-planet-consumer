namespace :parcc do
  desc 'Import PARCC data'
  task import: :environment do
    Parcc::Importers::Turnover.import

    Parcc::Importers::Species.import_taxonomies
    Parcc::Importers::Species.import_counts
  end
end
