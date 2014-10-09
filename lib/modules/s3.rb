class S3
  def initialize
    @s3 = AWS::S3.new({
      access_key_id: Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_access_key
    })
  end

  def download_from_bucket(bucket: bucket,filename: filename)


  end

end