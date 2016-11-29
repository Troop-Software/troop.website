class ScoutRequirement < ActiveRecord::Base
  belongs_to :scout
  belongs_to :requirement
end