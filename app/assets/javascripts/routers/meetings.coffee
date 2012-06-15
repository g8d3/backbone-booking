class window.MeetingsRouter extends Backbone.Router
  routes:
    'meetings': 'index'

  index: -> @view = new MeetingIndex()
