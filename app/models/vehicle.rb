class Vehicle < ApplicationRecord
  validates :name, presence: true
  validates :belts, presence: true

end