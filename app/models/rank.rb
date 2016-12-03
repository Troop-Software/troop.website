class Rank < ApplicationRecord
  validates :name, presence: true, length: {minimum: 4, maximum: 30}
  validates_uniqueness_of :name
  has_many :scouts
  has_many :requirements
  has_many :scout_rank_histories
end
