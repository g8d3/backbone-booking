3.times do
  tenant = Tenant.create name: 'tenant' + (Tenant.count + 1)
  landlord = Landlord.create name: 'landlord' + (Landlord.count + 1)
  Meeting.create landlord: landlord, tenant: tenant, at: Time.now
end
