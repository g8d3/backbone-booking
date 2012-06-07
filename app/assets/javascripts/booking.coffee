jQuery(document).ready ->
  window.router = new MeetingsRouter()
  Backbone.history.start pushState: true
  router.navigate('meetings', trigger: true)