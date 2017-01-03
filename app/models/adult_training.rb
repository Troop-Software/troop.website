class AdultTraining < ApplicationRecord
  belongs_to :adult
  belongs_to :adult_training_course

  validates :adult_id, presence: true
  validates :adult_training_course_id, presence: true
  validates :completed_date, presence: true

end