class window.Meeting extends Backbone.Model

  cancel: (callbacks = {}) ->
    @save {cancelled: true}, success: callbacks.success, error: callbacks.error

  class: -> if @get('cancelled') then 'cancelled' else ''

class window.Meetings extends Backbone.Collection
  url: '/meetings'
  model: Meeting
