class Parcc::Importers::ProtectedAreas < Parcc::Importers::Base
  IDENTITY = -> (value) { value }
  FIRST_ISO_3 = -> (countries) { countries.first[:iso_3] }

  PA_PROPERTIES = {
    iso_3:       {source: :api, key: :countries,   block: FIRST_ISO_3},
    name:        {source: :csv, key: :name,        block: IDENTITY},
    wdpa_id:     {source: :csv, key: :wdpaid,      block: IDENTITY},
    poly_id:     {source: :csv, key: :polyid,      block: IDENTITY},
    parcc_id:    {source: :csv, key: :'',          block: IDENTITY},
    iucn_cat:    {source: :csv, key: :iucn_cat,    block: IDENTITY},
    designation: {source: :csv, key: :designation, block: IDENTITY},
    geom_type:   {source: :csv, key: :point,       block: IDENTITY}
  }

  def self.import
    instance = new
    instance.import
  end

  def import
    csv_reader.each do |record|
      next unless properties = merge_properties(
        api: props_from_pp(record[:wdpaid]),
        csv: record
      )

      Parcc::ProtectedArea.create(properties)
    end
  end

  private

  def create_pa wdpa_id
    properties = props_from_pp wdpa_id
    return unless properties

    Parcc::ProtectedArea.create(properties)
  end

  def props_from_pp wdpa_id
    ProtectedPlanetReader.protected_area_from_wdpaid wdpa_id
  rescue ProtectedPlanetReader::ProtectedAreaRetrievalError => e
    Rails.logger.info e.message
    return {}
  end

  def merge_properties sources
    PA_PROPERTIES.each_with_object({}) do |(key, config), props|
      raw_value = sources[config[:source]][config[:key]]
      next unless raw_value

      props[key] = config[:block].(raw_value)
    end
  end

  def source_file_path
    Rails.root.join('lib/data/parcc/protected_areas.csv')
  end
end
