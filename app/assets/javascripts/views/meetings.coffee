class window.MeetingIndex extends Backbone.View

  className: 'container-fluid'

  initialize: (options = {}) ->
    options[key] ||= val for key, val of fetch: true, render: true
    @collection = options.collection || new Meetings()
    @template = options.template || JST['meeting/index']
    @row = options.row || JST['meeting/row']
    if options.fetch then @collection.fetch success: => if options.render then @render()

  render: (options = {}) ->
    options[key] ||= val for key, val of writeTo: 'body', enhanceUI: true
    @$el.html(@template(collection: @collection, row: @row))
    $(options.writeTo).html(@el) if options.writeTo
    @enhanceUI() if options.enhanceUI
    this

  enhanceUI: ->
    booking.landlords.fetch success: ->
      $('input[name=landlord_id]').autocomplete
        source: booking.landlords.models.map (landlord) -> value: landlord.id, label: landlord.get('name')
    booking.tenants.fetch success: ->
      $('input[name=tenant_id]').autocomplete
        source: booking.tenants.models.map (tenant) -> value: tenant.id, label: tenant.get('name')
    $('input[name=at]').pickDateTime()
    $('input[name=landlord_id]').focus()

  events:
    'click form#new_meeting .button': 'create'
    'click form#new_meeting label[for!=at]': 'openAutocomplete'
    'click form#new_meeting label[for=at]': 'focusAtDisplay'
    'blur form#new_meeting input': 'checkValue'
    'click a.cancel': 'cancel'
    'click a.delete': 'delete'
    'click .dismiss': 'dismiss'

  create: (event) ->
    event.preventDefault()
    @collection.create($('form#new_meeting').serializeObject(), wait: true)

  openAutocomplete: (event) -> $(event.target).nextAll('input:first').autocomplete('search')
    
  focusAtDisplay: -> $('input#at_display').focus()

  checkValue: (event) -> console.log 'dsad'

  cancel: (event) ->
    event.preventDefault()
    id = $(event.target).closest('tr').data('id')
    @collection.get(id).toggleCancel
      success: (model) ->
        $(event.target).closest('tr').toggleClass('cancelled', model.get('cancelled'))
        $(event.target).html(model.cancelLabel())
      error: -> $(event.target).closest('tr').addClass('error-cancelling')

  delete: (event) ->
    event.preventDefault()
    id = $(event.target).closest('tr').data('id')
    @collection.get(id).destroy
      success: (model) ->
        $(event.target).closest('tr').fadeOut('slow', -> $(@).html('<span class="dismiss">Removed!</span>')).fadeIn('slow')

  dismiss: (event) ->
    $(event.target).fadeOut('slow')
