class Day < ApplicationRecord
  belongs_to :user
  has_many :time_records

  validates :date, presence: true

  accepts_nested_attributes_for :time_records, allow_destroy: true
end
