class MeritBadge < ApplicationRecord
  has_many :scout_merit_badges
  has_many :scouts, through: :scout_merit_badges
end    