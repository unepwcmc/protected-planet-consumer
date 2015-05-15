require 'csv'

class Parcc::Importers::Turnover
  STATS = ['median', 'upper', 'lower']
  MATCH_COLUMNS = {
    parcc_id: '',
    name: 'name',
    iso_3: 'country',
    poly_id: 'polyID',
    designation: 'designation',
    geom_type: 'point',
    iucn_cat: 'iucn_cat',
    wdpa_id: 'WDPAID'
  }

  def self.import
    instance = new
    instance.import
  end

  def import
    files.each { |file| populate_values file }
  end

  def populate_values file_path
    split_filename = File.basename(file_path).split

    read_csv(file_path).each do |pa|
      parcc_props = {
        taxonomic_class: split_filename.first,
        year: split_filename[3]
      }

      pa.each do |k,v|
        if STATS.include? k
          parcc_props[:stat] = k
          parcc_props[:value] = v
          create_turnover parcc_props, pa['']
        end
      end
    end
  end

  def create_turnover parcc_values, parcc_id
    parcc_values.merge!(parcc_protected_area_id: pa_id_from_parcc_id(parcc_id))
    Parcc::SpeciesTurnover.create parcc_values
  end

  def files
    @files ||= Dir['lib/data/parcc/turnover/*']
  end

  def read_csv file_path
    CSV.foreach(file_path, headers: true)
  end

  def pa_id_from_parcc_id parcc_id
    @pa_ids ||= {}
    @pa_ids[parcc_id] ||= db.select_value(
      "SELECT id from parcc_protected_areas where parcc_id = #{parcc_id.to_i}"
    ).instance_eval { to_i unless nil? }
  end

  def db
    ActiveRecord::Base.connection
  end
end
