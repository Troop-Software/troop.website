class YouthAward < ApplicationRecord
  validates :name, presence: true

  has_many :youth_award_requirements, dependent: :destroy
  accepts_nested_attributes_for :youth_award_requirements
end