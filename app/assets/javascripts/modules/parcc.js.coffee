window.Parcc = class Parcc
  constructor: ->
    @initializeMap($('#map'))

  initializeMap: ($mapContainer) ->
    new Map($mapContainer).render()

$(document).ready(->
  new Parcc()
  table = $('.vulnerable-species-table').DataTable({
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": false,
      "bInfo": false,
      "sScrollX": "100%",
      "sScrollY": "300px",
      "scrollCollapse": true,
      "columns" : [
        { "sWidth": "200px"},
        { "sWidth": "120px"},
        { "sWidth": "120px"},
        { "sWidth": "120px"},
        { "sWidth": "150px"},
        { "sWidth": "250px"},
        { "sWidth": "250px"}
      ]
  })
  new $.fn.dataTable.FixedColumns(table)

)
