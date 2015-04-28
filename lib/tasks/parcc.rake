namespace :parcc do
  desc 'Import PARCC data'
  task import: :environment do
    turnover_importer = Parcc::Importer::Turnover.new
    turnover_importer.import
  end
end
