class window.Tenant extends Backbone.Model

class window.Tenants extends Backbone.Collection
  url: '/tenants'
  model: Tenant
