class Booking.Autocomplete extends Backbone.View
  template: JST['/meeting/autocomplete']

  initialize: (options = {}) ->
    @collection = options.collection

  render: ->
    @$el.html(@template(collection: @collection)).find('#' + @collection)
    this

  events:
    'click label': 'focusDisplay'
