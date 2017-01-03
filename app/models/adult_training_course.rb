class AdultTrainingCourse < ApplicationRecord
  has_many :adult_trainings
  has_many :adults, through: :adult_trainings
end