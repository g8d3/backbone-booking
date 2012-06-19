class window.MeetingsRouter extends Backbone.Router
  routes:
    'meetings': 'index'

  index: -> new MeetingIndex()
