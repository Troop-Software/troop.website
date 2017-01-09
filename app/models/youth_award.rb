class YouthAward < ApplicationRecord
  validates :name, presence: true

  has_many :youth_award_requirements, dependent: :destroy
  accepts_nested_attributes_for :youth_award_requirements
  has_many :scout_awards
  has_many :scouts, through: :scout_awards
end