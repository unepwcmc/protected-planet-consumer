class Parcc::Importers::SuitabilityChanges < Parcc::Importers::Base
  extend Memoist
  SPECIES_RANGE = (5..-3)

  def self.import
    new.import
  end

  def import
    files.each { |file| populate_values file }
  end

  def populate_values file_path
    split_filename = File.basename(file_path, '.csv').split
    year = split_filename[4]

    csv = csv_reader(file_path).to_a
    populate_species(csv.shift, taxon_class_id_from_name(split_filename.first))

    csv.each { |record| create_record(record, year) }
  end

  def populate_species record, taxonomic_class_id
    @all_species = record[SPECIES_RANGE].map do |species_name|
      name = species_name.gsub('_', ' ')

      Parcc::Species.find_or_create_by(name: name) do |species|
        species.parcc_taxonomic_order_id = Parcc::TaxonomicOrder.find_or_create_by(
          name: 'Not Available',
          parcc_taxonomic_class_id: taxonomic_class_id
        ).id
      end
    end
  end

  WDPA_ID_COLUMN = -2
  def create_record record, year
    protected_area_id = pa_id_from_wdpa_id record[WDPA_ID_COLUMN]

    record[SPECIES_RANGE].zip(@all_species).each do |value, species|
      Parcc::SuitabilityChange.create(
        species: species,
        value: value,
        year: year,
        parcc_protected_area_id: protected_area_id
      )
    end
  end

  def csv_reader file_path
    CSV.read(file_path, headers: true)
  end

  define_method(:db) { ActiveRecord::Base.connection }

  memoize def files
    Dir['lib/data/parcc/suitability_changes/*']
  end

  memoize def pa_id_from_wdpa_id wdpa_id
    db.select_value(
      "SELECT id from parcc_protected_areas where wdpa_id = #{wdpa_id.to_i}"
    ).instance_eval { to_i unless nil? }
  end

  memoize def taxon_class_id_from_name name
    db.select_value(
      "SELECT id from parcc_taxonomic_classes where name = '#{name}'"
    ).instance_eval { to_i unless nil? }
  end
end
