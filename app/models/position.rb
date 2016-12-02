class Position < ApplicationRecord
  validates :name, presence: true, length: {minimum: 5, maximum: 50}
  validates_uniqueness_of :name

  has_many :scouts

  before_save do |position|
    position.name = position.name.downcase.titlecase
  end
end
