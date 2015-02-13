namespace :gef do
  desc 'Import gef data'
  task import: :environment do
    BUCKET_NAME = 'gef-protected-areas'
    FILENAME = 'lib/data/gef_full_database.csv'

    Gef::Area.delete_all
    Gef::WdpaRecord.delete_all
    Gef::PameRecord.delete_all

    importer = Gef::Importer.new(filename: FILENAME, bucket_name: BUCKET_NAME)
    importer.import
  end
end