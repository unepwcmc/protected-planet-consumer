require 'test_helper'
require 'csv'
class TestGefImporter < ActiveSupport::TestCase
  test '.convert_to_hash reads csv and converts to array of hashes' do
    filename = 'long_tables.csv'
    parsed_csv = [['name in file', 'age'], ['wolf', 10], ['dog', 20]]

    result = [{ 'name in file' => 'wolf', 'age' => 10 }, { 'name in file' => 'dog', 'age' => 20 }]

    CSV.expects(:read).with(filename).returns(parsed_csv)

    assert_equal result, Gef::Importer.convert_to_hash(filename)
  end

  test '.find_fields creates a hash with columns of model and values' do

    FactoryGirl.create(:gef_column_match, model_columns: 'pa_name_mett', xls_columns: 'name in file')
    FactoryGirl.create(:gef_column_match, model_columns: 'research', xls_columns: 'Research')

    protected_area = { 'name in file' => 'wolf', 'Research' => 4 }

    result = { pa_name_mett:  'wolf', research: 4 }

    assert_equal result, Gef::Importer.find_fields(protected_area)
  end

  test 'import creates protected areas from csv file' do

    filename = 'long_tables.csv'

    parsed_csv = [['name in file', 'Research'], ['wolf', 4], ['dog', 7]]

    CSV.expects(:read).with(filename).returns(parsed_csv)

    FactoryGirl.create(:gef_column_match, model_columns: 'pa_name_mett', xls_columns: 'name in file')
    FactoryGirl.create(:gef_column_match, model_columns: 'research', xls_columns: 'Research')

    GefProtectedArea.expects(:create).with(pa_name_mett: 'wolf', research: 4)
    GefProtectedArea.expects(:create).with(pa_name_mett: 'dog', research: 7)

    Gef::Importer.import(filename)
  end
end
