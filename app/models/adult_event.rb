class AdultEvent < ApplicationRecord
  validates :adult_id, presence: true
  validates :event_id, presence: true
  validates :notes, length: {minimum: 5, maximum: 254}, allow_blank: true
  validates :adult_id, uniqueness: {scope: :event_id, :message => ' is already part of this event'}

  belongs_to :adult
  belongs_to :event

  scope :events_in_60_day_window, -> { joins(:event).where('events.start between ? and ?', 30.days.ago, 30.days.from_now) }
  scope :events_in_year_window, -> { joins(:event).where('events.start between ? and ?', 1.year.ago, 1.year.from_now) }
end