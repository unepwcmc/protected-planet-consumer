require 'test_helper'
require 'csv'

class TestParccImportersSpecies < ActiveSupport::TestCase
  test '.import_taxonomies calls Parcc::Importers::Species::Taxonomies.import' do
    Parcc::Importers::Species::Taxonomies.expects(:import)
    Parcc::Importers::Species.import_taxonomies
  end

  test '.import_counts calls Parcc::Importers::Species::Counts.import' do
    Parcc::Importers::Species::Counts.expects(:import)
    Parcc::Importers::Species.import_counts
  end
end
