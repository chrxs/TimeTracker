class DaySerializer < ActiveModel::Serializer
  attributes :id, :date

  has_many :time_records
end
