class @Booking
  @defaults:
    autocomplete:
      minLength: 0
      select: (event, ui) ->
        event.preventDefault()
        cloned = $(@).attr('id') == "displayed_#{$(@).next().attr('id')}"
        if !cloned
          clone = $(@).clone().hide()
          $(@).after(clone)
          $(@).attr(name: null, id: "displayed_#{$(@).attr('id')}")
        else
          clone = $(@).next()
        clone.val(ui.item.value)
        $(@).val(ui.item.label)
      focus: (event, ui) ->
        event.preventDefault()
        $(@).focus()
        $(@).val(ui.item.label)

    will_pickdate: timePicker: true, format: 'j F Y H:i', inputOutputFormat: 'Y-m-dTH:i:s'

    navigate: url: 'meetings', options: trigger: true

  constructor: (options = {}) ->
    @landlords = new Landlords()
    @landlords.fetch success: =>
      @tenants = new Tenants()
      @tenants.fetch success: =>
        @router = new MeetingsRouter()
        Backbone.history.start pushState: true
        if options.navigate != false
          options.navigate ||= Booking.defaults.navigate
          @router.navigate(options.navigate.url, options.navigate.options)

$.fn.pickDateTime = (options) -> @will_pickdate($.extend Booking.defaults.will_pickdate, options)

$.extend $.ui.autocomplete.prototype.options, Booking.defaults.autocomplete
