require 'test_helper'
require 'csv'

class TestGefImporter < ActiveSupport::TestCase

    def setup
        @filename = 'long_tables.csv'
    end

  test '.find_fields creates a hash with columns of model and values' do

    FactoryGirl.create(:gef_column_match, model_columns: 'pa_name_mett', xls_columns: 'name in file')
    FactoryGirl.create(:gef_column_match, model_columns: 'research', xls_columns: 'Research')

    protected_area = { 'name in file' => 'wolf', 'Research' => 4 }

    result = { pa_name_mett:  'wolf', research: 4 }

    importer = Gef::Importer.new(filename: @filename, bucket_name: 'a_s3_bucket')

    assert_equal result, importer.find_fields(protected_area)
  end

  test '.find_fields ignores columns not matching' do

    FactoryGirl.create(:gef_column_match, model_columns: 'pa_name_mett', xls_columns: 'name in file')
    FactoryGirl.create(:gef_column_match, model_columns: 'research', xls_columns: 'Research')

    protected_area = { 'name in file' => 'wolf', 'name we dont want' => 'human', 'Research' => 4 }

    result = { pa_name_mett:  'wolf', research: 4 }

    importer = Gef::Importer.new(filename: @filename, bucket_name: 'a_s3_bucket')

    assert_equal result, importer.find_fields(protected_area)
  end

  test 'import creates protected areas from csv file with same pmis id and different wdpa_id' do

    FactoryGirl.create(:gef_column_match, model_columns: 'pa_name_mett', xls_columns: 'PA NAME (METT)')
    FactoryGirl.create(:gef_column_match, model_columns: 'gef_pmis_id', xls_columns: 'GEF PMIS ID')
    FactoryGirl.create(:gef_column_match, model_columns: 'wdpa_id', xls_columns: 'WDPA ID (METT)')
    FactoryGirl.create(:gef_column_match, model_columns: 'mett_original_uid', xls_columns: 'METT UID1')
    FactoryGirl.create(:gef_column_match, model_columns: 'budget_recurrent', xls_columns: 'Budget (Recurrent)')
    FactoryGirl.create(:gef_column_match, model_columns: 'budget_project', xls_columns: 'Budget (Project)')

    parsed_csv = [ { "GEF PMIS ID" => '111222', 'PA NAME (METT)' => 'wolf', 'WDPA ID (METT)' => 999888,
                    'METT UID1' => 1122, 'Budget (Recurrent)' => 'n/a', 'Budget (Project)' => 'Not Given' },
                   { "GEF PMIS ID" => '111222', 'PA NAME (METT)' => 'wolf', 'WDPA ID (METT)' => 666777,
                    'METT UID1' => 1234, 'Budget (Recurrent)' => 'Not Given', 'Budget (Project)' =>  654321},
                   { "GEF PMIS ID" => '111222', 'PA NAME (METT)' => 'wolf', 'WDPA ID (METT)' => 666777,
                    'METT UID1' => 4321, 'Budget (Recurrent)' => 123456, 'Budget (Project)' => 'n/a' },
                 ]

    CSV.stubs(:read).with('long_tables.csv', {:headers => true}).returns(parsed_csv)

    Gef::Area.expects(:find_or_create_by).with(gef_pmis_id: 111222).times(3)
    Gef::PameName.expects(:find_or_create_by).with(name: 'wolf').times(3)

    Gef::BudgetType.expects(:find_or_create_by).with(name: 'n/a').times(2)
    Gef::BudgetType.expects(:find_or_create_by).with(name: 'Not Given').times(2)
    Gef::BudgetType.expects(:find_or_create_by).with(name: 'Given').times(2)

    area_mock_1 = mock
    area_mock_1.expects(:first).returns(id: 333444).times(3)

    Gef::Area.expects(:where).with('gef_pmis_id = ?', 111222).returns(area_mock_1).times(3)

    name_mock = mock
    name_mock.expects(:first).returns(id: 5566).times(3)

    Gef::PameName.expects(:where).with('name = ?', 'wolf').returns(name_mock).times(3)

    Gef::WdpaRecord.expects(:find_or_create_by).with(wdpa_id: 999888, gef_area_id: 333444, gef_pame_name_id: 5566)
    Gef::WdpaRecord.expects(:find_or_create_by).with(wdpa_id: 666777, gef_area_id: 333444, gef_pame_name_id: 5566).twice

    wdpa_mock_1 = mock
    wdpa_mock_1.expects(:first).returns(id: 1111)

    wdpa_mock_2 = mock
    wdpa_mock_2.expects(:first).returns(id: 2222).twice

    Gef::WdpaRecord.expects(:where).with('wdpa_id = ?', 999888).returns(wdpa_mock_1).once
    Gef::WdpaRecord.expects(:where).with('wdpa_id = ?', 666777).returns(wdpa_mock_2).twice

    budget_mock_1 = mock
    budget_mock_1.expects(:first).returns(id:666).twice

    budget_mock_2 = mock
    budget_mock_2.expects(:first).returns(id:999).twice

    budget_mock_3 = mock
    budget_mock_3.expects(:first).returns(id:969).twice

    Gef::BudgetType.expects(:where).with('name = ?', 'Not Given').returns(budget_mock_1).twice
    Gef::BudgetType.expects(:where).with('name = ?', 'Given').returns(budget_mock_2).twice
    Gef::BudgetType.expects(:where).with('name = ?', 'n/a').returns(budget_mock_3).twice

    Gef::PameRecord.expects(:create).with(gef_pame_name_id: 5566, gef_wdpa_record_id: 1111, mett_original_uid: 1122, gef_area_id: 333444,
                                          budget_recurrent_type_id: 969, budget_project_type_id: 666)
    Gef::PameRecord.expects(:create).with(gef_pame_name_id: 5566, gef_wdpa_record_id: 2222, mett_original_uid: 1234, gef_area_id: 333444,
                                          budget_recurrent_type_id: 666, budget_project_type_id: 999, budget_project_value: 654321)
    Gef::PameRecord.expects(:create).with(gef_pame_name_id: 5566, gef_wdpa_record_id: 2222, mett_original_uid: 4321, gef_area_id: 333444,
                                          budget_recurrent_type_id: 999, budget_project_type_id: 969, budget_recurrent_value: 123456)

    s3_response_mock = mock
    s3_response_mock.expects(:download_from_bucket)

    S3.expects(:new).returns(s3_response_mock)

    importer = Gef::Importer.new(filename: @filename, bucket_name: 'a_s3_bucket')
    importer.import
  end
end
