window.DropDown = class DropDown
  constructor: (@$container_el, @table, @table_type) ->
    @placeholder = @$container_el.children('span')
    @opts = @$container_el.find('ul.dropdown > li')
    @val = ''
    @index = -1
    @initEvents()

  initEvents: ->
    @$container_el.on('click', (event) ->
      $(this).toggleClass('active')
      false
    )

    self = @
    @opts.on('click', ->
      opt = $(this)
      self.val = opt.text()
      self.index = opt.index()
      self.placeholder.text(self.val)
      wdpa_id = $('#map').data("wdpa-id")

      self.table.loading()
      $.ajax(
        url: "#{wdpa_id}/#{self.table_type}?taxonomic_class=#{self.val}"
        error: (jqXHR, textStatus, errorThrown) ->
          console.log("AJAX Error: #{textStatus}")
        success: (data, textStatus, jqXHR) ->
          self.table.$container_el.html(data)
          self.table.reload()
          self.table.ready()
      )
    )

  getValue: -> @val
  getIndex: -> @index
