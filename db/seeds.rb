3.times do
  tenant = Tenant.create name: 'tenant' + (Tenant.count + 1).to_s
  landlord = Landlord.create name: 'landlord' + (Landlord.count + 1).to_s
  Meeting.create landlord: landlord, tenant: tenant, at: Time.now
end
