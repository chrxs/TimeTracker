class TimeRecord < ApplicationRecord
  belongs_to :day
  belongs_to :project

  validates :amount, presence: true
end
