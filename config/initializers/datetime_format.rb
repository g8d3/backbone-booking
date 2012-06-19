class ActiveSupport::TimeWithZone
  def as_json(options = {})
    strftime(I18n.t(:datetime_format))
  end
end
