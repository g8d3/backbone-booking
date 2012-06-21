class Meeting < ActiveRecord::Base
  attr_accessible :at, :landlord_id, :landlord, :tenant_id, :tenant, :cancelled
  validates_presence_of :at, message: I18n.t(:please_fill_meeting_time)
  validates_presence_of :landlord, message: I18n.t(:please_fill_landlord)
  validates_presence_of :tenant, message: I18n.t(:please_fill_tenant)
  validate :busy_landlord, on: :create

  belongs_to :landlord
  belongs_to :tenant

  def busy_landlord
    errors.add :landlord, landlord.name + ' ' + I18n.t(:is_busy, at: at.strftime(I18n.t(:datetime_format))) if landlord.try(:busy?, at)
  end
end
