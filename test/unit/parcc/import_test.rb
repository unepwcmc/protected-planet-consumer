require 'test_helper'

class ParccImportTest < ActiveSupport::TestCase
  test '::configuration returns the configuration yaml' do
    assert_not_nil Parcc::Import.configuration['taxonomic_classes']
  end
end
