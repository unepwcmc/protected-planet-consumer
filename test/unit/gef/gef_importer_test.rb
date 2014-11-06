require 'test_helper'
require 'csv'

class TestGefImporter < ActiveSupport::TestCase

  test '.gef_ids imports ids to gef_areas' do

    filename = 'long_tables.csv'

    CSV.expects(:foreach).multiple_yields([1,1])

    Gef::Area.expects(:create).with(gef_pmis_id: 1)

    importer = Gef::Importer.new(filename: filename, bucket_name: 'a_s3_bucket')
    importer.gef_ids
  end

  test '.convert_to_hash reads csv and converts to array of hashes' do
    filename = 'long_tables.csv'
    parsed_csv = [['name in file', 'age'], ['wolf', 10], ['dog', 20]]

    result = [{ 'name in file' => 'wolf', 'age' => 10 }, { 'name in file' => 'dog', 'age' => 20 }]

    CSV.expects(:read).with(filename).returns(parsed_csv)

    importer = Gef::Importer.new(filename: filename)

    assert_equal result, importer.convert_to_hash
  end

  test '.find_fields creates a hash with columns of model and values' do

    filename = 'long_tables.csv'

    FactoryGirl.create(:gef_column_match, model_columns: 'pa_name_mett', xls_columns: 'name in file')
    FactoryGirl.create(:gef_column_match, model_columns: 'research', xls_columns: 'Research')

    protected_area = { 'name in file' => 'wolf', 'Research' => 4 }

    result = { pa_name_mett:  'wolf', research: 4 }

    importer = Gef::Importer.new(filename: filename, bucket_name: 'a_s3_bucket')

    assert_equal result, importer.find_fields(protected_area)
  end

  test '.find_fields ignores columns not matching' do

    filename = 'long_tables.csv'

    FactoryGirl.create(:gef_column_match, model_columns: 'pa_name_mett', xls_columns: 'name in file')
    FactoryGirl.create(:gef_column_match, model_columns: 'research', xls_columns: 'Research')

    protected_area = { 'name in file' => 'wolf', 'name we dont want' => 'human', 'Research' => 4 }

    result = { pa_name_mett:  'wolf', research: 4 }

    importer = Gef::Importer.new(filename: filename, bucket_name: 'a_s3_bucket')

    assert_equal result, importer.find_fields(protected_area)
  end

  test 'import creates protected areas from csv file' do

    filename = 'long_tables.csv'

    parsed_csv = [['GEF_PMIS_ID','name in file'], [1, 'wolf']]

    CSV.expects(:read).with(filename).returns(parsed_csv)
    CSV.expects(:foreach).multiple_yields(1)

    FactoryGirl.create(:gef_column_match, model_columns: 'pa_name_mett', xls_columns: 'name in file')

    Gef::WdpaRecord.expects(:create).with(pa_name_mett: 'wolf')


    s3_response_mock = mock
    s3_response_mock.expects(:download_from_bucket)

    S3.expects(:new).returns(s3_response_mock)

    importer = Gef::Importer.new(filename: filename, bucket_name: 'a_s3_bucket')
    importer.import
  end
end
