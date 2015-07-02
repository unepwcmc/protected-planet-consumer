require 'zip'

module Parcc::Downloads
  BASE_PATH = Rails.root.join('tmp/downloads')
  GENERATORS = [
    Parcc::Downloads::Generators::SuitabilityChanges,
    Parcc::Downloads::Generators::Turnovers,
    Parcc::Downloads::Generators::Vulnerability,
    Parcc::Downloads::Generators::ProtectedAreaInfo
  ]

  def self.generate protected_area
    create_folder_if_needed
    zip_path = BASE_PATH.join("#{protected_area.wdpa_id}-#{protected_area.name}.zip")

    unless File.exists?(zip_path)
      generate_and_clean(protected_area) { |csv_paths| create_zip(zip_path, csv_paths) }
    end

    zip_path
  end

  def self.generate_and_clean protected_area
    csv_paths = GENERATORS.map { |generator| generator.generate(protected_area) }

    begin
      yield csv_paths
    ensure
      FileUtils.rm csv_paths
    end
  end

  def self.create_zip zip_path, all_csv_paths
    Zip::File.open(zip_path, Zip::File::CREATE) do |zipfile|
      all_csv_paths.each do |csv_path|
        filename = File.basename(csv_path)
        zipfile.add(filename, csv_path)
      end
    end
  end

  def self.create_folder_if_needed
    FileUtils.mkdir(BASE_PATH) unless File.exists?(BASE_PATH)
  end
end
