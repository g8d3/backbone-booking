class window.MeetingIndex extends Backbone.View

  className: 'container-fluid'

  initialize:  ->
    _.defaults @options, fetch: true, render: true
    @collection = @options.collection || booking.meetings
    @template = @options.template || JST['meeting/index']
    @row = @options.row || JST['meeting/row']
    @collection.on 'sync', @addRow, this
    booking.landlords.on 'sync', @autocompleteAdd, this
    booking.tenants.on 'sync', @autocompleteAdd, this
    if @options.render then @render()

  render: (options = {}) ->
    _.defaults options, writeTo: 'body', enhanceUI: true
    @$el.html(@template(collection: @collection, row: @row))
    $(options.writeTo).html(@el) if options.writeTo
    @enhanceUI() if options.enhanceUI
    this

  addRow: (model) ->
    $('tbody').append(@row(model: model))

  autocompleteAdd: (model) ->
    collection = model.constructor.name.toLowerCase() + 's'
    hidden = $('input[name=' + model.constructor.name.toLowerCase() + '_id]')
    displayed = $('input#displayed_' + model.constructor.name.toLowerCase() + '_id')
    hidden.val(model.id)
    hidden.nextAll('.btn:first').hide()
    hidden.nextAll('.alert:first').show(0, -> $(@).fadeOut(1500))
    displayed.autocomplete 'option', source: booking[collection].forAutocomplete()

  enhanceUI: ->
    $('input[name=landlord_id]').autocomplete
      source: booking.landlords.forAutocomplete()
    $('input[name=landlord_id]').after($('<span class="create-user btn btn-warning">Create</span>').hide())
    $('input[name=landlord_id]').after($('<span class="alert alert-success centered">Created</span>').hide())
    $('input[name=tenant_id]').autocomplete
      source: booking.tenants.forAutocomplete()
    $('input[name=tenant_id]').after($('<span class="create-user btn btn-warning">Create</span>').hide())
    $('input[name=tenant_id]').after($('<span class="alert alert-success centered">Created</span>').hide())
    $('input[name=at]').pickDateTime()
    $('input[name=landlord_id]').focus()

  events:
    'click form#new_meeting input[name!=at]': 'openAutocomplete'
    'keyup form#new_meeting input': 'showCreate'
    'keydown form#new_meeting input': 'createOnEnter'
    'click form#new_meeting .create-user': 'createUser'
    'click form#new_meeting label[for=at]': 'focusAtDisplay'
    'click form#new_meeting .create-meeting': 'create'
    'click a.cancel': 'cancel'
    'click a.delete': 'delete'
    'click .alert.removed': 'dismiss'

  openAutocomplete: (event) -> $(event.target).autocomplete('search')

  showCreate: (event) ->
    if ['displayed_landlord_id', 'displayed_tenant_id'].indexOf(event.target.id) != -1
      collection = event.target.id.match(/tenant|landlord/)[0] + 's'
      $(event.target).nextAll('.btn').first().toggle(booking[collection].pluck('name').indexOf(event.target.value) == -1 &&
      event.target.value[0]?)

  createOnEnter: (event) ->
    if ['displayed_landlord_id', 'displayed_tenant_id'].indexOf(event.target.id) != -1
      collection = event.target.id.match(/tenant|landlord/)[0] + 's'
      if booking[collection].pluck('name').indexOf(event.target.value) == -1 && event.target.value[0]? && event.keyCode == 13
        booking[collection].create name: event.target.value, wait: true

  createUser: (event) ->
    collection = $(event.target).prevAll('input').first().attr('id').match(/tenant|landlord/)[0] + 's'
    displayed = $(event.target).prevAll('input[id*=displayed]').first()
    hidden = $(event.target).prevAll('input:first:hidden')
    booking[collection].create name: displayed.val(), wait: true

  focusAtDisplay: -> $('input#at_display').focus()

  create: (event) ->
    event.preventDefault()
    response = @collection.create $('form#new_meeting').serializeObject(),
      wait: true
      error: (model, response) ->
        errors = JSON.parse(response.responseText).errors
        $('form').append($('<div class="alert alert-error"></div>').html(errors.landlord[0]).alert())

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
        -> $(@).html('<td colspan="4" class="alert alert-warning removed">Meeting removed!</td>')).fadeIn('slow')

  dismiss: (event) ->
    $(event.target).fadeOut('slow')
