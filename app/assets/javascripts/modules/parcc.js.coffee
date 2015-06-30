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
        { "sWidth": "400px"},
        { "sWidth": "380px"}
      ],
      "columnDefs" : [
        { "sortable": true, "targets": 0},
        { "sortable": true, "targets": 1},
        { "sortable": false, "targets": 2},
        { "sortable": true, "targets": 3},
        { "sortable": true, "targets": 4},
        { "sortable": false, "targets": 5},
        { "sortable": false, "targets": 6},
      ]
  })
  new $.fn.dataTable.FixedColumns(table)

)
