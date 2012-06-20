describe 'booking application', ->

  beforeEach ->
    $('body').append($('<div class="sandbox"></div>'))
    @callback = jasmine.createSpy()
    $(document).on 'booking:started', @callback
    window.booking = new Booking navigate: false
    waitsFor -> @callback.callCount > 0

  it 'triggers booking:started event on document when application has started successfully', ->
    runs -> expect(@callback).toHaveBeenCalled()

  describe 'given some meeting', ->
    beforeEach ->
      finished = null
      @landlord = Booking.Factories.landlord()
      @tenant = Booking.Factories.tenant()
      @meeting = Booking.Factories.meeting()
      @landlord.save {}, success: =>
        @tenant.save {}, success: =>
          @meeting.save {landlord_id: @landlord.id, tenant_id: @tenant.id}, success: => finished = true
      waitsFor -> finished
      runs ->
        booking.landlords.add(@landlord)
        booking.tenants.add(@tenant)
        booking.meetings.add(@meeting)
        index = new MeetingIndex(render: false, collection: booking.meetings)
        index.render(writeTo: '.sandbox')

    it 'shows user a meeting list', ->
      expect($('.sandbox tbody tr').length).toEqual(1)

    it 'shows meeting landlord name', ->
      expect($('.sandbox tbody tr').html()).toMatch(@landlord.get('name'))

    it 'shows meeting tenant name', ->
      expect($('.sandbox tbody tr').html()).toMatch(@tenant.get('name'))

    it 'shows meeting formatted datetime as ', ->
      expect($('.sandbox tbody tr').html()).toMatch(@meeting.get('at'))

    afterEach ->
      Booking.Factories.clear()

  afterEach ->
    $('.sandbox').remove()
    Backbone.history.stop()
