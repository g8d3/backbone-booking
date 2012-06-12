module Factories
  def landlord(override = {})
    Landlord.new({name: 'testing landlord'}.merge override)
  end

  def meeting(override = {})
    Meeting.new({at: Time.now}.merge override)
  end

  def tenant(override = {})
    Tenant.new({name: 'testing tenant'}.merge override)
  end
end
