class window.Tenant extends Backbone.Model
  urlRoot: -> '/tenants/' + (@id || '')

class window.Tenants extends Backbone.Collection
  url: '/tenants'
  model: Tenant

  forAutocomplete: -> @map (tenant) -> value: tenant.id, label: tenant.get('name')
