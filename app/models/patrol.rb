class Patrol < ApplicationRecord
  validates :name, presence: true, length: {minimum: 5, maximum: 50}
  validates_uniqueness_of :name
  has_many :scouts
end
