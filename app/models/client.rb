class Client < ApplicationRecord
  has_many :projects, dependent: :destroy
  belongs_to :team

  validates :name, presence: true
  validates :name, uniqueness: true

  accepts_nested_attributes_for :projects
end
