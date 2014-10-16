require 'test_helper'

class TestGefImporter < ActiveSupport::TestCase

  # read csv

  test '.convert_to_hash reads csv and converts to array of hashes' do 
    filename = 'long_tables.csv'
    parsed_csv = [['name', 'age'], ['wolf', 10], ['dog', 20]]
    
    CSV.expects(:read).with(filename).returns(parsed_csv)

    Gef::Importer.convert_to_hash(filename: filename)
  end
    
  # match

  #populate model 
end
