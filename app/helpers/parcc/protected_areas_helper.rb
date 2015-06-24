module Parcc::ProtectedAreasHelper

  PATH_TO_PROTECTED_AREA = -> wdpa_id { "http://www.protectedplanet.net/#{wdpa_id}" }
  def protected_planet_path page
    {
      root: 'http://www.protectedplanet.net',
      blog: 'http://blog.protectedplanet.net',
      about: 'http://www.protectedplanet.net/about',
      un_list: 'http://blog.protectedplanet.net/post/102481051829/2014-united-nations-list-of-protected-areas',
      protected_area: PATH_TO_PROTECTED_AREA
    }[page]
  end

  def high_priority_warning protected_area
    "<div class=\"other-info\">
      <p class=\"info\">
        <i class=\"fa fa-exclamation-circle\"></i>
        <strong>#{protected_area.name}</strong> is among the top 75 protected areas
          assessed as being the <strong>most vulnerable to climate change by 2025</strong>
          (with a 95% uncertainty level)
      </p>
    </div>".html_safe if protected_area.high_priority
  end
end
