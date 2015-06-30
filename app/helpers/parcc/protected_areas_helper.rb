module Parcc::ProtectedAreasHelper
  URL_TO_PROTECTED_AREA = -> wdpa_id { "http://www.protectedplanet.net/#{wdpa_id}" }
  def protected_planet_path page
    {
      root: 'http://www.protectedplanet.net',
      blog: 'http://blog.protectedplanet.net',
      about: 'http://www.protectedplanet.net/about',
      un_list: 'http://blog.protectedplanet.net/post/102481051829/2014-united-nations-list-of-protected-areas',
      protected_area: URL_TO_PROTECTED_AREA
    }[page]
  end

  def high_priority_warning protected_area
    %Q(
      <div class="other-info">
        <p class="info">
          <i class="fa fa-exclamation-circle"></i>
          <strong>#{protected_area.name}</strong> is among the top 75 protected areas
            assessed as being the <strong>most vulnerable to climate change by 2025</strong>
            (with a 95% uncertainty level)
        </p>
      </div>
    ).html_safe if protected_area.high_priority
  end

  LEGEND_PATH = Rails.root.join('config/parcc/vulnerability_legend.yml')
  VULNERABILITY_LEGEND = YAML.load(File.read(LEGEND_PATH))

  def traits type, pa_species
    all_traits = VULNERABILITY_LEGEND[type.to_s][pa_species.taxonomic_class.name]

    species_traits = pa_species.send(type).to_s
    species_traits_as_array = species_traits.split(',').map(&:to_i)

    species_traits_as_array.each_with_object(Set.new) do |trait, set|
      set << "<li>#{all_traits[trait]}</li>"
    end.to_a.join("\n").html_safe
  end

  def exposure_check exposure
    klass = exposure.present? ? "fa fa-check" : "no-icon"
    %Q(<i class="#{klass}"></i>).html_safe
  end

  def taxonomic_classes_options
    select_tag "class_id", options_for_select(
      Parcc::Import.configuration["taxonomic_classes"].map do |taxonomic_class|
        [taxonomic_class, Parcc::TaxonomicClass.find_by(name: taxonomic_class).id]
      end
    )
  end

  IUCN_COLORS = {
    "EX" => "black",
    "EW" => "purple",
    "CR" => "red",
    "EN" => "orange",
    "VU" => "yellow",
    "NT" => "light-green",
    "LC" => "green",
    "DD" => "grey",
    "NE" => "white"
  }
  def iucn_value_icon value
    %Q(#{value} <i class="fa fa-circle #{IUCN_COLORS[value]}"></i>).html_safe
  end

  ICONS = {"Inc" => "fa-arrow-circle-up green", "Dec" => "fa-arrow-circle-down red"}
  def suitability_value_icon value
    %Q(#{value} <i class="fa #{ICONS[value]}"></i>).html_safe
  end

end
