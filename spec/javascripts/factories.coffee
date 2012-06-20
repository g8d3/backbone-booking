window.Booking.Factories =
  tenant: (overrides) ->
    new Tenant($.extend({name: 'client tenant'}, overrides))

  landlord: (overrides) ->
    new Landlord($.extend({name: 'client landlord'}, overrides))

  meeting: (overrides) ->
    new Meeting($.extend({at: new Date()}, overrides))

  clear: (options) ->
    new Landlords().fetch success: (landlords) -> landlords.each (landlord) -> landlord.destroy()

