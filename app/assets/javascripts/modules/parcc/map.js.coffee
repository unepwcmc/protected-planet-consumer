window.Map = class Map
  L.mapbox.accessToken = 'pk.eyJ1IjoidW5lcHdjbWMiLCJhIjoiRXg1RERWRSJ9.taTsSWwtAfFX_HMVGo2Cug'

  CONFIG =
    minZoom: 2
    zoomControl: false
    attributionControl: false

  constructor: (@$mapContainer) ->

  render: ->
    if @$mapContainer.length == 0
      return false

    config = @$mapContainer.data()
    map = @createMap(@$mapContainer.attr('id'))

    @addBaseLayers(map)
    ProtectedAreaOverlay.render(map, config)

  createMap: (id) ->
    L.mapbox.map(
      id, 'unepwcmc.l8gj1ihl', CONFIG
    ).addControl(L.control.zoom(position: 'topleft'))

  addBaseLayers: (map) ->
    terrain = L.mapbox.tileLayer('unepwcmc.l8gj1ihl')
    satellite = L.mapbox.tileLayer('unepwcmc.lac5fjl1')

    L.control.layers({"Terrain": terrain, "Satellite": satellite}, {}, position: 'topleft').addTo(map)
