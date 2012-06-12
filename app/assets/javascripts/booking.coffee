jQuery.fn.as_json = ->
  $.parseJSON "{\"#{$(@).serialize().replace(/&/g, '","').replace(/\=/g, '":"')}\"}"

window.start = ->
  window.landlords = new Landlords()
  window.tenants = new Tenants()
  window.router = new MeetingsRouter()
  Backbone.history.start pushState: true
