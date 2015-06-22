window.Parcc = class Parcc
  constructor: ->
    @initializeMap($('#map'))

  initializeMap: ($mapContainer) ->
    new Map($mapContainer).render()

$(document).ready(-> new Parcc() )
