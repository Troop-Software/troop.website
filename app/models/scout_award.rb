class ScoutAward < ApplicationRecord
  validates :scout_id, presence: true
  validates :youth_award_id, presence: true
  validates :completed_date, presence: true

  belongs_to :scout
  belongs_to :youth_award
end