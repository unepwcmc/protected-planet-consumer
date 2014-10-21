class Gef::Download

  def initialize(bucket_name, filename)
    @bucket_name = bucket_name
    @filename = filename
  end

  def from_s3
    s3 = S3.new(@bucket_name)
    s3.download_from_bucket(filename: @filename)
  end
end
