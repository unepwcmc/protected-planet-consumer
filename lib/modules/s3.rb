class S3
  def initialize(bucket_name)
    @s3 = AWS::S3.new(
      access_key_id: Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_access_key
    )
    @bucket_name = bucket_name
  end

  def download_from_bucket(filename: filename)
    File.open(filename, 'w:ASCII-8BIT') do |file|
      file.write last_file.read
    end
  end

  private

  def last_file
    available_files.sort_by(&:last_modified).last
  end

  def available_files
    @s3.buckets[@bucket_name].objects
  end
end
