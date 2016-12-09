class ScoutMeritBadge < ActiveRecord::Base
    belongs_to :scout
    belongs_to :merit_badge
end
