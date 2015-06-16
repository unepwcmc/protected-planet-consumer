class Parcc::Importers::HighPriorityProtectedAreas < Parcc::Importers::Base

  def self.import
    instance = new
    instance.import
  end

  def import
    populate_values source_file_path
  end

  def populate_values file_path
    read_csv(file_path).each do |record|
      update_area(record)
    end
  end

  def update_area record
    Parcc::ProtectedArea.find_by({name: name(record)}).try(:update, high_priority: true)
  end

  def name record
    record.to_hash[:name]
  end

  def read_csv file_path
    CSV.read(file_path, headers: true, header_converters: :symbol)
  end

  def source_file_path
    Rails.root.join('lib/data/parcc/high_priority_protected_areas.csv')
  end

end
