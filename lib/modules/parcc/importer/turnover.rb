require 'csv'

class Parcc::Importer::Turnover
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

  def import
    create_pas files.first
    files.each { |file| populate_values file }
  end

  def create_pas file_path
    protected_areas = read_csv(file_path)

    protected_areas.each do |pa|
      pa_props = MATCH_COLUMNS.each_with_object({}) do |(final, original), props|
        props[final] = pa[original] if pa[original]
      end

      Parcc::ProtectedArea.create(pa_props)
    end
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
    pa = Parcc::ProtectedArea.where(parcc_id: parcc_id).select(:id).first

    parcc_values.merge!(parcc_protected_area_id: pa.id)
    Parcc::SpeciesTurnover.create parcc_values
  end

  def files
    @files ||= Dir['lib/data/parcc/*']
  end

  def read_csv file_path
    CSV.foreach(file_path, headers: true)
  end
end
