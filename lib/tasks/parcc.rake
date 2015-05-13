namespace :parcc do
  desc 'Import PARCC data'
  task import: :environment do
    Parcc::Importers::Species.import_taxonomies
    Parcc::Importers::Species.import_counts

    Parcc::Importers::Turnover.import
  end
end
