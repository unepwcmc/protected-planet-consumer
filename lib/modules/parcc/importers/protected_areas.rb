class Parcc::Importers::ProtectedAreas < Parcc::Importers::Base
  IDENTITY = -> (value) { value }
  FIRST_ISO_3 = -> (countries) { countries.first[:iso_3] }

  PA_PROPERTIES = {
    iso_3:       :country,
    name:        :name,
    wdpa_id:     :wdpaid,
    poly_id:     :polyid,
    parcc_id:    :'',
    iucn_cat:    :iucn_cat,
    designation: :designation,
    geom_type:   :point
  }

  def self.import
    instance = new
    instance.import
  end

  def import
    csv_reader(source_file_path).each do |record|
      Parcc::ProtectedArea.create(
        collect_properties(record)
      )
    end
  end

  private

  def collect_properties record
    PA_PROPERTIES.each_with_object({}) do |(key, original_key), props|
      props[key] = record[original_key]
    end
  end

  def source_file_path
    Rails.root.join('lib/data/parcc/protected_areas.csv')
  end
end
