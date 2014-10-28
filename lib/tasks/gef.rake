namespace :gef do
  desc 'Import gef data'
  task import: :environment do
    BUCKET_NAME = 'gef-protected-areas'
    FILENAME = 'tmp/gef.csv'

    importer = Gef::Importer.new(filename: FILENAME, bucket_name: BUCKET_NAME)
    importer.import
  end
end