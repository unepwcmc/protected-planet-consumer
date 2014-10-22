namespace :gef do
  desc 'Import gef data'
  task import: :environment do
    BUCKET_NAME = 'gef-protected-areas'
    FILENAME = 'tmp/gef.csv'

    importer = Gef::Import.new(FILENAME)
    importer.import
  end
end