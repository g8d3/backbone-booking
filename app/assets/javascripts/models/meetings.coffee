class window.Meeting extends Backbone.Model

  initialize: (attributes = {}) ->

  toggleCancel: (callbacks = {}) ->
    @save {cancelled: !@get('cancelled')}, success: callbacks.success, error: callbacks.error

  class: -> if @get('cancelled') then 'cancelled' else ''

  cancelLabel: -> if @get('cancelled') then 'Undo cancel' else 'Cancel'

  landlord: -> booking.landlords.get(@get 'landlord_id')

class window.Meetings extends Backbone.Collection
  url: '/meetings'
  model: Meeting
