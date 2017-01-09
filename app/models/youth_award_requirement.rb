class YouthAwardRequirement < ApplicationRecord
  validates :req_num, presence: true
  validates :description, presence: true

  belongs_to :youth_award
end