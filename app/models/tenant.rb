class Tenant < User
  has_many :meetings
  has_many :landlords, through: :meetings, uniq: true
end
