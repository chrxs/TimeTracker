class WeekdaySettingSerializer < ActiveModel::Serializer
  attributes :id, :day_of_week, :required_minutes_logged

end
