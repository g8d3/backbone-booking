class Landlord < User
  has_many :meetings, dependent: :destroy
  has_many :tenants, through: :meetings, uniq: true

  def busy?(at)
    meetings.where('at between ? and ?', at - 15.minutes, at + 15.minutes).exists?
  end
end
