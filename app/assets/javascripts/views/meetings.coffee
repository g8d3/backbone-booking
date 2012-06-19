class window.MeetingIndex extends Backbone.View

  className: 'container-fluid'

  initialize: (options = {}) ->
    options[key] ||= val for key, val of fetch: true, render: true
    @collection = options.collection || booking.meetings
    @template = options.template || JST['meeting/index']
    @row = options.row || JST['meeting/row']
    if options.fetch then @collection.fetch success: => if options.render then @render()
    @collection.on 'add', @addOne, this

  render: (options = {}) ->
    options[key] ||= val for key, val of writeTo: 'body', enhanceUI: true
    @$el.html(@template(collection: @collection, row: @row))
    $(options.writeTo).html(@el) if options.writeTo
    @enhanceUI() if options.enhanceUI
    this

  addOne: (model) ->
    $('tbody').append(@row(model: model))

  enhanceUI: ->
    $('input[name=landlord_id]').autocomplete
      source: booking.landlords.forAutocomplete()
    $('input[name=landlord_id]').after($('<span class="create-user btn btn-warning">Create</span>').hide())
    $('input[name=tenant_id]').autocomplete
      source: booking.tenants.forAutocomplete()
    $('input[name=tenant_id]').after($('<span class="create-user btn btn-warning">Create</span>').hide())
    $('input[name=at]').pickDateTime()
    $('input[name=landlord_id]').focus()

  events:
    'click form#new_meeting label[for!=at]': 'openAutocomplete'
    'keyup form#new_meeting input': 'checkValue'
    'click form#new_meeting .create-user': 'createUser'
    'click form#new_meeting label[for=at]': 'focusAtDisplay'
    'click form#new_meeting .create-meeting': 'create'
    'click a.cancel': 'cancel'
    'click a.delete': 'delete'
    'click .dismiss.button': 'dismiss'

  openAutocomplete: (event) -> $(event.target).nextAll('input:first').autocomplete('search')

  checkValue: (event) ->
    if ['displayed_landlord_id', 'displayed_tenant_id'].indexOf(event.target.id) != -1
      collection = event.target.id.match(/tenant|landlord/)[0] + 's'
      $(event.target).nextAll('.btn').first().toggle(booking[collection].pluck('name').indexOf(event.target.value) == -1 &&
      event.target.value[0]?)

  createUser: (event) ->
    collection = $(event.target).prevAll('input').first().attr('id').match(/tenant|landlord/)[0] + 's'
    response = booking[collection].create name: $(event.target).prevAll('input[id*=displayed]').first().val(), wait: true
    if response
      $(event.target).prevAll('input[id*=displayed]').autocomplete 'option', source: booking[collection].forAutocomplete()
      created = $('<span class="alert alert-success centered">Created</span>')
      $(event.target).hide().after(created)
      created.fadeOut(1500)

  focusAtDisplay: -> $('input#at_display').focus()

  create: (event) ->
    event.preventDefault()
    @collection.create($('form#new_meeting').serializeObject(), wait: true)

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
        $(event.target).closest('tr').fadeOut('slow',
        -> $(@).html('<span class="dismiss button">Removed!</span>')).fadeIn('slow')

  dismiss: (event) ->
    $(event.target).fadeOut('slow')

