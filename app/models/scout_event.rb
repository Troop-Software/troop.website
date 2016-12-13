class ScoutEvent < ApplicationRecord
  validates :scout_id, uniqueness: { scope: :event_id, :message => ' is already part of this event' }

  belongs_to :scout
  belongs_to :event
end
