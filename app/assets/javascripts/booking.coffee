class @Booking
  @defaults:
    autocomplete:
      minLength: 0
      create: (event, ui) ->
        $(@).after($(@).clone().hide())
        $(@).attr(name: null, id: "displayed_#{$(@).attr('id')}")
      select: (event,ui) ->
        event.preventDefault()
        clone = $(@).nextAll('input:first:hidden')
        clone.val(ui.item.value)
        $(@).val(ui.item.label)
      focus: (event, ui) ->
        event.preventDefault()
        $(@).focus()
        $(@).val(ui.item.label)

    will_pickdate: timePicker: true, format: 'j F Y H:i', inputOutputFormat: 'Y-m-dTH:i'

    navigate: url: 'meetings', options: trigger: true

  constructor: (options = {}) ->
    @landlords = new Landlords()
    @landlords.fetch success: =>
      @tenants = new Tenants()
      @tenants.fetch success: =>
        @meetings = new Meetings()
        @meetings.fetch success: =>
          @router = new MeetingsRouter()
          Backbone.history.start pushState: true
          if options.navigate != false
            options.navigate ||= Booking.defaults.navigate
            @router.navigate(options.navigate.url, options.navigate.options)
          $(document).trigger('booking:started')

$.fn.pickDateTime = (options) -> @will_pickdate($.extend Booking.defaults.will_pickdate, options)

$.extend $.ui.autocomplete.prototype.options, Booking.defaults.autocomplete
