class DaySerializer < ActiveModel::Serializer
  attributes :id, :date, :user_id

  has_many :time_records
end
