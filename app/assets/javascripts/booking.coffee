jQuery(document).ready ->
  window.landlords = new Landlords()
  window.tenants = new Tenants()
  window.router = new MeetingsRouter()
  Backbone.history.start pushState: true
  router.navigate('meetings', trigger: true)

jQuery.fn.as_json = ->
  $.parseJSON "{\"#{$(@).serialize().replace(/&/g, '","').replace(/\=/g, '":"')}\"}"
