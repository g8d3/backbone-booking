class window.MeetingIndex extends Backbone.View

  template: JST['meeting/index']

  render: ->
    window.x= @collection
    @collection.fetch
      success: => @$el.html(@template(collection: @collection))
    this

  events:
    'click tr[id*=meetings]': 'goToShow'
    'keydown #new_meeting input': 'createOnEnter'

  goToShow: (event) ->
    router.navigate(event.currentTarget.id.replace('_', '/'), trigger: true)

  createOnEnter: (event)->
#    if event.keyCode == 13
#      new Meeting($()).save()


class window.MeetingShow extends Backbone.View
  template: JST['meeting/show']

  render: ->
    @model.fetch
      success: => @$el.html(@template(model: @model))
    this
