#= require ../../app/assets/javascripts/booking
describe 'booking application', ->
  it 'has a start method', ->
    expect(start).toBeDefined()

  describe 'start', ->
    it 'creates a router that shows user a meeting list', ->
      start()
      spyOn(router, 'navigate')
      router.navigate('meetings', trigger: true)
