namespace :gef do
  desc 'Import gef data'
  task import: :environment do
    BUCKET_NAME = 'gef-protected-areas'
    FILENAME = 'public/gef/gef_full_database.csv'

    Gef::Area.delete_all
    Gef::PameName.delete_all
    Gef::WdpaRecord.delete_all
    Gef::BudgetType.delete_all
    Gef::PameRecord.delete_all
    Gef::PameRecordWdpaRecord.delete_all
    Gef::Biome.delete_all
    Gef::Country.delete_all
    Gef::Region.delete_all

    importer = Gef::Importer.new(filename: FILENAME, bucket_name: BUCKET_NAME)
    importer.import

    consumer = Gef::Consumer.new

  end
end
