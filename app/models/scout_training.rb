class ScoutTraining < ApplicationRecord
  belongs_to :scout
  belongs_to :youth_training

  validates :scout_id, presence: true
  validates :youth_training_id, presence: true
  validates :completed_date, presence: true

end
