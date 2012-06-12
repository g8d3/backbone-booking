class window.Meeting extends Backbone.Model

class window.Meetings extends Backbone.Collection
  url: '/meetings'
  model: Meeting
