class Parcc::Importers::Species
  def self.import_taxonomies
    Taxonomies.import
  end

  def self.import_counts
    Counts.import
  end
end
