class window.MeetingIndex extends Backbone.View

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @add, this)
    @collection.fetch()

  template: JST['meeting/index']

  render: ->
    @$el.html(@template(collection: @collection))
    window.landlords.fetch success: ->
      $('input[name=landlord_id]').autocomplete
        source: window.landlords.models.map (landlord) -> value: landlord.id, label: landlord.get('name')
    window.tenants.fetch success: ->
      $('input[name=tenant_id]').autocomplete
        source: window.tenants.models.map (tenant) -> value: tenant.id, label: tenant.get('name')
    $('input[name=at]').will_pickdate timePicker: true, format: 'j F Y H:i', inputOutputFormat: 'Y-m-d H:i:s'
    this

  add: (meeting) ->
    console.log 'sadsadad'

  events:
    'keydown form#new_meeting input': 'createOnEnter'
    'click form#new_meeting button': 'create'

  createOnEnter: (event)->
    @collection.create($('form#new_meeting').as_json(), wait: true) if event.keyCode == 13

  create: ->
    @collection.create($('form#new_meeting').as_json(), wait: true)

class window.MeetingShow extends Backbone.View
  template: JST['meeting/show']

  render: ->
    @model.fetch
      success: =>
        @$el.html(@template(model: @model))
    this
