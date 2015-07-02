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
      { "sWidth": "200px" },
      { "sWidth": "120px" },
      { "sWidth": "200px" },
      { "sWidth": "120px" },
      { "sWidth": "120px" },
      { "sWidth": "400px" },
      { "sWidth": "380px" }
    ],
    "columnDefs" : [
      { "sortable": true, "targets": 0 },
      { "sortable": true, "targets": 1 },
      { "sortable": false, "targets": 2 },
      { "sortable": true, "targets": 3 },
      { "sortable": true, "targets": 4 },
      { "sortable": false, "targets": 5 },
      { "sortable": false, "targets": 6 },
    ]
  })
  new $.fn.dataTable.FixedColumns(table)

  $('.suitability-table').DataTable({
    "bPaginate": false,
    "bLengthChange": false,
    "bFilter": false,
    "bInfo": false,
    "sScrollY": "300px",
    "scrollCollapse": true,
    "columns" : [
      { "sWidth": "30%" },
      { "sWidth": "15%" },
      { "sWidth": "15%" },
      { "sWidth": "40%" }
    ],
    "columnDefs" : [
      { "sortable": true, "targets": [0,1,2] },
      { "sortable": false, "targets": 3 }
    ]
  })

  $(".tooltip").tooltip();


  DropDown = (el) ->
    this.dd = el;
    this.placeholder = this.dd.children('span');
    this.opts = this.dd.find('ul.dropdown > li');
    this.val = '';
    this.index = -1;
    this.initEvents();

  DropDown.prototype = {
    initEvents: () ->
        obj = this;

        obj.dd.on('click', (event) ->
            $(this).toggleClass('active');
            return false;
        );

        obj.opts.on('click', ->
            opt = $(this);
            obj.val = opt.text();
            obj.index = opt.index();
            obj.placeholder.text(obj.val);
        );

    getValue: () ->
        return this.val;

    getIndex: () ->
        return this.index;
  }

  dd_vulnerability = new DropDown( $('#dd-vulnerability') )
  dd_suitability = new DropDown( $('#dd-suitability'))
  $(document).click( () ->
    $('.wrapper-dropdown').removeClass('active')
  )
  # $(".dataTables_scrollBody").scroll(->
  #   if($(this).scrollLeft())
  #     console.log("Scrolled")
  #     $(".scrolling-shadow").addClass("scrolled")
  #   else
  #     console.log("End scroll")
  #     $(".scrolling-shadow").removeClass("scrolled")
  # )
)
