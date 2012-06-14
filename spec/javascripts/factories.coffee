window.Factories =
  tenant: (overrides) ->
    new Tenant($.extend({name: 'client tenant'}, overrides))

