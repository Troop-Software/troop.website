class ScoutEvent < ApplicationRecord
  validates :scout_id, presence: true
  validates :event_id, presence: true
  validates :notes, length: {minimum: 5, maximum: 254}, allow_blank: true
  validates :scout_id, uniqueness: { scope: :event_id, :message => ' is already part of this event' }

  belongs_to :scout
  belongs_to :event

  scope :events_in_60_day_window, -> { joins(:event).where('events.start between ? and ?', 30.days.ago, 30.days.from_now) }
 # scope :today, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }



end
