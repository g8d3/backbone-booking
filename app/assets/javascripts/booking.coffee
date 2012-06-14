class window.Booking
  defaults:
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

  start: ->
    window.landlords = new Landlords()
    window.tenants = new Tenants()
    window.router = new MeetingsRouter()
    Backbone.history.start pushState: true
window.booking = new Booking()

$.fn.pickDateTime = (options) -> @will_pickdate($.extend booking.defaults.will_pickdate, options)

$.extend $.ui.autocomplete.prototype.options, booking.defaults.autocomplete
