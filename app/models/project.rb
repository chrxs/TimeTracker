class Project < ApplicationRecord
  has_many :time_records

  validates :name, presence: true
  validates :name, uniqueness: true
end
