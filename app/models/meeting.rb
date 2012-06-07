class Meeting < ActiveRecord::Base
  attr_accessible :at, :landlord_id, :tenant_id
end
