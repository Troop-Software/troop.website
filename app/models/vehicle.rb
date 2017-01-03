class Vehicle < ApplicationRecord
  validates :name, presence: true
  validates :belts, presence: true

  has_many :adult_vehicles
  has_many :adults, through: :adult_vehicles
end