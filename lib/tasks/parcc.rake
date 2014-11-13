namespace :parcc do
  desc 'Import PARCC data'
  task import: :environment do
    importer = Parcc::Importer.new
    importer.import
  end
end