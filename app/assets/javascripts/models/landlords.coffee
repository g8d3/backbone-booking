class window.Landlord extends Backbone.Model

class window.Landlords extends Backbone.Collection
  url: '/landlords'
  model: Landlord
