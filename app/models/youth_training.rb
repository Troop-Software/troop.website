class YouthTraining < ApplicationRecord
  has_many :scout_trainings
  has_many :scouts, through: :scout_trainings
end
