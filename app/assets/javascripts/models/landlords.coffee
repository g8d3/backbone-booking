class window.Landlord extends Backbone.Model
  urlRoot: -> '/landlords/' + (@id || '')

class window.Landlords extends Backbone.Collection
  url: '/landlords'
  model: Landlord
