class Gef::Importer::Download
  BUCKET_NAME = 'pp-consumer'
  FILENAME = 'tmp/gef_db.mdb'

  def self.mdb_from_s3
    s3 = S3.new(BUCKET_NAME)
    s3.download_from_bucket(filename: FILENAME)
  end
end
