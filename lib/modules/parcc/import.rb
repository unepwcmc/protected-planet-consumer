module Parcc::Import
  IMPORT_CONFIGURATION = File.read(Rails.root.join('config/parcc/import.yml'))
  def self.configuration
    @@configuration ||= YAML.load(IMPORT_CONFIGURATION)
  end
end
