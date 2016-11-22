class Rank < ApplicationRecord
  validates :name, presence: true, length: {minimum: 4, maximum: 30}
  has_many :scouts
end
