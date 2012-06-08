class window.MeetingsRouter extends Backbone.Router

  routes:
    'meetings': 'index'
    'meetings/:id': 'show'

  index: ->
    $('body').html(new MeetingIndex({collection: new Meetings()}).render().el)

  show: (id)->
    $('body').html(new MeetingShow({model: new Meeting({id: id})}).render().el)
