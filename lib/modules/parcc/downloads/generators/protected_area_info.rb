module Parcc::Downloads::Generators::ProtectedAreaInfo
  BASE_PATH = Rails.root.join('tmp/downloads/')

  HEADERS = [
    'WDPAID',
    'Name',
    'Country',
    'Designation',
    'IUCN Category',
    'Total count of species',
    'Count Vulnerable Species',
    'Percentage Vulnerable Species',
    'High Priority Protected Area'
  ]

  def self.generate protected_area
    filename = "#{protected_area.wdpa_id}_protected_area_info.csv"
    full_path = BASE_PATH.join(filename)

    CSV.open(full_path, 'wb') do |csv|
      csv << HEADERS
      csv << collect_values(protected_area)
    end

    full_path
  end

  def self.collect_values protected_area
    [
      protected_area.wdpa_id,
      protected_area.name,
      protected_area.iso_3,
      protected_area.designation,
      protected_area.iucn_cat,
      protected_area.count_total_species,
      protected_area.count_vulnerable_species,
      protected_area.percentage_vulnerable_species,
      protected_area.high_priority
    ]
  end
end
