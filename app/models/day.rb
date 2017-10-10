class Day < ApplicationRecord
  belongs_to :user
  has_many :time_records

  validates :date, presence: true

  accepts_nested_attributes_for :time_records, allow_destroy: true

  def recorded_time
    self.time_records.pluck(:amount).reduce(:+)
  end
end
