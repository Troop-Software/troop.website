class Event < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :start, presence: true
  validates :category, presence: true
  
  enum category: [:troop_meeting, :campout, :outing, :plc, :committee_meeting, 
                    :service_project, :training, :other]

  has_many :scout_events
  has_many :scouts, through: :scout_events

  scope :events_in_60_day_window, -> {where('events.start between ? and ?', 30.days.ago, 30.days.from_now) }
  # scope :today, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }


  def self.search(search)
    if search
      #search by id
      #where('category LIKE ?', "%#{search}%")
      #seach exact match
      where(category: Event.categories[search.parameterize.underscore.to_sym])
    else
      all
    end
  end
end
