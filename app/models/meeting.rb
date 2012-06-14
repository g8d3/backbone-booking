class Meeting < ActiveRecord::Base
  attr_accessible :at, :landlord_id, :landlord, :tenant_id, :tenant, :cancelled
  validates_presence_of :at, :landlord, :tenant
  #validate { errors.add :landlord, "Landlord is busy #{at.strftime('on %D at %R')}" if landlord.busy?(at)}
  belongs_to :landlord
  belongs_to :tenant

end
