window.Table = class Table
  DEFAULTS = {
    "bPaginate": false,
    "bLengthChange": false,
    "bFilter": false,
    "bInfo": false,
    "sScrollY": "400px",
    "scrollCollapse": true,
    "bDestroy": true
  }

  constructor: (@el, @$container_el, @opts) ->
    @reload(opts)

  reload: ->
    debugger
    table_opts = $.extend({}, DEFAULTS, @opts)
    table = $(@el).DataTable(table_opts)
    new $.fn.dataTable.FixedColumns(table)

  hide: => @$container_el.hide()
  show: => @$container_el.show()
