class Event < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :category, presence: true

  enum category: [:troop_meeting, :camping, :cabin_camping, :outing, :plc, :committee_meeting,
                  :service_project, :training, :hiking, :horseback, :watercraft,
                  :backpacking, :other]

  has_many :scout_events
  has_many :scouts, through: :scout_events
  has_many :adult_events
  has_many :adults, through: :adult_events

  scope :events_in_60_day_window, -> { where('events.start between ? and ?', 30.days.ago, 30.days.from_now) }
  scope :events_in_year_window, -> { where('events.start between ? and ?', 1.year.ago, 1.year.from_now) }
  # scope :today, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }

  def date_range
    return self.start.strftime('%m/%d/%Y') if self.end.blank?
    "#{self.start.strftime('%m/%d/%Y')} - #{self.end.strftime('%m/%d/%Y')}"
  end

  def logged
    case self.category
      when 'camping', 'cabin_camping'
        return "#{self.logged_units.to_i} Nights"
      when 'hiking', 'horseback', 'watercraft', 'backpacking'
        return "#{self.logged_units} Miles"
      when 'troop_meeting', 'plc', 'committee_meeting', 'service_project', 'training'
        return "#{self.logged_units} Hours"
      else
        return self.logged_units
    end
  end
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

  def self.to_csv(report)
    CSV.generate(headers: true) do |csv|
      case report
        when 'troopCalendar'
          csv << %w{ID TITLE STARTDATE ENDDATE DESCRIPTION URL}
          all.each do |event|
            csv << [event.title, event.start, event.end, event.description, event.external_link]
          end
        else
          csv << ["#{report} not found"]
      end
    end
  end
end
