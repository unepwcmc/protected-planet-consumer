namespace :gef do
  desc 'Import gef data'
  task import: :environment do
    BUCKET_NAME = 'gef-protected-areas'
    FILENAME = 'tmp/gef.csv'

    downloader = Gef::Download.new(BUCKET_NAME,FILENAME)
    downloader.from_s3

    importer = Gef::Import.new(FILENAME)
    importer.import
  end
end