class window.MeetingIndex extends Backbone.View

  initialize: ->
    @collection.on('reset add', @render, this)
    @collection.fetch()

  template: JST['meeting/index']

  render: ->
    @$el.html(@template(collection: @collection))
    $('input[name=at]').datepicker()
    this

  events:
    'click tr[id*=meetings]': 'goToShow'
    'keydown form#new_meeting input': 'createOnEnter'

  goToShow: (event) ->
    router.navigate(event.currentTarget.id.replace('_', '/'), trigger: true)

  createOnEnter: (event)->
    @collection.create($('form#new_meeting').as_json()) if event.keyCode == 13


class window.MeetingShow extends Backbone.View
  template: JST['meeting/show']

  render: ->
    @model.fetch
      success: =>
        @$el.html(@template(model: @model))
    this
