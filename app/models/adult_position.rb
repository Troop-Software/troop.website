class AdultPosition < ApplicationRecord
  validates :name, presence: true, length: {minimum: 5, maximum: 50}
  validates :abbr, presence: true, length: {minimum: 2, maximum: 5}
  validates_uniqueness_of :name
  validates_uniqueness_of :code
  validates_uniqueness_of :abbr
end