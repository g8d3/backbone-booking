class window.Meeting extends Backbone.Model
  url: -> "/meetings/#{@get('id')}"

class window.Meetings extends Backbone.Collection
  url: '/meetings'
  model: Meeting