class Project < ApplicationRecord
  has_many :time_records
  belongs_to :client

  validates :name, presence: true
  validates :name, uniqueness: true
end
