window.Parcc = class Parcc
  constructor: ->
    @initializeMap($('#map'))

  initializeMap: ($mapContainer) ->
    new Map($mapContainer).render()

$(document).ready(->

  vulnerability_opts = {
    "sScrollX": "100%",
    "scrollCollapse": true,
    "columns" : [
      { "sWidth": "200px" },
      { "sWidth": "120px" },
      { "sWidth": "200px" },
      { "sWidth": "120px" },
      { "sWidth": "400px" },
      { "sWidth": "380px" }
    ],
    "columnDefs": [
      { "sortable": true, "targets": 0 },
      { "sortable": true, "targets": 1 },
      { "sortable": false, "targets": 2 },
      { "sortable": true, "targets": 3 },
      { "sortable": false, "targets": 4 },
      { "sortable": false, "targets": 5 },
    ],
    "language": {
      "emptyTable": "No species of this taxon have been assessed as being vulnerable to climate change"
    }
  }

  suitability_opts = {
    "columns" : [
      { "sWidth": "30%" },
      { "sWidth": "25%" },
      { "sWidth": "25%" },
      { "sWidth": "20%" }
    ],
    "columnDefs": [
      { "sortable": true, "targets": 0 },
      { "sortable": true, "targets": 1 },
      { "sortable": true, "targets": 2 },
      { "sortable": false, "targets": 3 }
    ],
    "language": {
      "emptyTable": "No species of this taxon have been assessed as being vulnerable to climate change"
    }
  }

  vulnerability_table = new Table('.vulnerability-table', $('.vulnerability-table-container'), vulnerability_opts)
  dd_vulnerability = new TabsPane($('#vulnerability-tabs'), vulnerability_table, 'vulnerability_table')
  suitability_table = new Table('.suitability-table', $('.suitability-table-container'), suitability_opts)
  dd_suitability = new TabsPane($('#suitability-tabs'), suitability_table, 'suitability_changes_table')

  new Parcc()

  $(".tooltip").tooltip()

)
