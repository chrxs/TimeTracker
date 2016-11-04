class User < ApplicationRecord
  has_many :days
  has_many :time_records, through: :days

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
