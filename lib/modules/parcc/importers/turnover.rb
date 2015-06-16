class Parcc::Importers::Turnover < Parcc::Importers::Base
  extend Memoist
  STATS = [:median, :upper, :lower]
  COLUMN_FOR_PARCC_ID = :'' # yes, as odd as it looks

  def self.import
    instance = new
    instance.import
  end

  def import
    files.each { |file| populate_values file }
  end

  def populate_values file_path
    split_filename = File.basename(file_path).split
    turnover_defaults = {
      taxonomic_class_id: taxon_class_id_from_name(split_filename.first),
      year: split_filename[3]
    }

    csv_reader(file_path).each do |record|
      create_record(turnover_defaults, record)
    end
  end

  def create_record defaults, record
    stats = record.to_hash.slice(*STATS)
    pa_id = {parcc_protected_area_id: pa_id_from_parcc_id(record[COLUMN_FOR_PARCC_ID])}

    Parcc::SpeciesTurnover.create defaults.merge(stats).merge(pa_id)
  end

  memoize def files
    Dir['lib/data/parcc/turnover/*']
  end

  memoize def pa_id_from_parcc_id parcc_id
    db.select_value(
      "SELECT id from parcc_protected_areas where parcc_id = #{parcc_id.to_i}"
    ).instance_eval { to_i unless nil? }
  end

  memoize def taxon_class_id_from_name name
    db.select_value(
      "SELECT id from parcc_taxonomic_classes where name = '#{name}'"
    ).instance_eval { to_i unless nil? }
  end

  define_method(:db) { ActiveRecord::Base.connection }
end
