class window.Landlord extends Backbone.Model
  urlRoot: -> '/landlords/' + (@id || '')

class window.Landlords extends Backbone.Collection
  url: '/landlords'
  model: Landlord

  forAutocomplete: -> @map (landlord) -> value: landlord.id, label: landlord.get('name')
