class Landlord < User
  has_many :meetings

  def busy?(at)
    meetings.where('at = ?', at).exists?
  end
end
