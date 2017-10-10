class DaySerializer < ActiveModel::Serializer
  attributes :id, :date, :user_id, :recorded_time

  has_many :time_records
end
