module Parcc::Downloads::Generators::Turnovers
  BASE_PATH = Rails.root.join('tmp/downloads/')

  HEADERS = [
    'Taxonomic Class',
    # 2040
    'Lower - by 2010-2039',
    'Median - by 2010-2039',
    'Upper - by 2010-2039',
    # 2070
    'Lower - by 2040-2069',
    'Median - by 2040-2069',
    'Upper - by 2040-2069',
    # 2100
    'Lower - by 2070-2099',
    'Median - by 2070-2099',
    'Upper - by 2070-2099'
  ]

  def self.generate protected_area
    filename = "#{protected_area.wdpa_id}_turnovers.csv"
    full_path = BASE_PATH.join(filename)

    CSV.open(full_path, 'wb') do |csv|
      csv << HEADERS

      grouped_turnovers(protected_area).each { |taxo_class, turnovers|
        csv << collect_values(taxo_class, turnovers)
      }
    end

    full_path
  end

  def self.collect_values taxo_class, turnovers
    [2040, 2070, 2100].inject([taxo_class]) { |values, year|
      values << turnovers[year].try(:lower)
      values << turnovers[year].try(:median)
      values << turnovers[year].try(:upper)
      values
    }
  end

  def self.grouped_turnovers protected_area
    ParccPresenter.grouped_turnovers(
      protected_area.species_turnovers
    )
  end
end
