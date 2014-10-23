require 'test_helper'

class TestS3 < ActiveSupport::TestCase
  def setup
    Rails.application.secrets.aws_access_key_id = '123'
    Rails.application.secrets.aws_secret_access_key = 'abc'
  end

  test '#new creates an S3 connection' do
    AWS::S3.expects(:new).with({
      :access_key_id     => '123',
      :secret_access_key => 'abc'
    })

    bucket_name = 'hey_i_am_a_bucket'

    S3.new(bucket_name)
  end

  test '.download_from_bucket retrieves the latest file from
  given bucket on S3, and saves it to the given filename' do

    latest_file_mock = mock
    latest_file_mock.stubs(:last_modified).returns(2.days.ago)
    latest_file_mock.expects(:read).returns('')

    oldest_file_mock = mock
    oldest_file_mock.stubs(:last_modified).returns(10.days.ago)
    oldest_file_mock.stubs(:read)
      .raises(Exception, 'Expected the oldest file to not be downloaded')

    bucket_mock = mock
    bucket_mock.stubs(:objects).returns([
      latest_file_mock,
      oldest_file_mock
    ])

    bucket_name = 'hey_i_am_a_bucket'

    s3_mock = mock
    s3_mock.stubs(:buckets).returns(bucket_name => bucket_mock)

    AWS::S3.expects(:new).returns(s3_mock)

    filename = 'hey_this_is_a_filename.mdb'

    file_write_mock = mock
    file_write_mock.stubs(:write)
    File.expects(:open)
      .with(filename, 'w:ASCII-8BIT')
      .yields(file_write_mock)

    s3 = S3.new(bucket_name)
    s3.download_from_bucket(filename: filename)
  end
end