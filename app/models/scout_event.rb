class ScoutEvent < ApplicationRecord
  validates :scout_id, presence: true
  validates :event_id, presence: true
  validates :notes, length: {minimum: 5, maximum: 254}, allow_blank: true
  validates :scout_id, uniqueness: {scope: :event_id, :message => ' is already part of this event'}

  belongs_to :scout
  belongs_to :event

  scope :events_in_60_day_window, -> { joins(:event).where('events.start between ? and ?', 30.days.ago, 30.days.from_now) }
  scope :events_in_year_window, -> { joins(:event).where('events.start between ? and ?', 1.year.ago, 1.year.from_now) }
  # scope :today, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }

  def self.import_participation(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url
    file = File.new(open(file, 'r'))

    post_processed_file = []
    while (line = file.gets)
      next if line =~ /\(.\*Cabin Camp.\)/
      next if line =~ /Scout Individual Participation Report/
      next if line =~ /Troop Activities/
      next if line =~ /Patrol:/
      next if line =~ /Current Rank:/
      next if line =~ /Pos'n of Respons/
      next if line =~ /Type/
      next if line =~ /Camping\s+Canoe/
      next if line =~ /Nights/
      next if line =~ /\d+\s\/\s\d+/
      next if line =~ /\(Page/
      next if line =~ /\(cont\)/
      next if line =~ /\s+Ski/
      next if line =~ /# \/ Amount/
      next if line =~ /Not valid toward/
      next if line.blank?
      post_processed_file << line
    end

    i = 0
    while i < post_processed_file.count do
      if post_processed_file[i] =~ /Name:/
        line_scout_name = post_processed_file[i][16..54].strip.split(', ')
        scout_name = "#{line_scout_name.last} #{line_scout_name.first}"
        scout_id = Scout.find_by_name(scout_name).id
        i += 1
        until post_processed_file[i] =~ /Name:/ || i >= post_processed_file.count do

          file_date = DateTime.strptime("#{post_processed_file[i][0..8]} 09:00 pm", '%m/%d/%y %I:%M %P')
          file_event_type = post_processed_file[i][10..25].strip
          file_event_duration = post_processed_file[i][26..31].strip.to_i
          file_event_location = post_processed_file[i][32..51].strip
          file_event_description = post_processed_file[i][52..80].strip
          Rails.logger.debug "#{line_scout_name} #{file_event_type}"

          # Find or create event
          case file_event_type
            when 'Camping'
              event = Event.find_or_create_by!(title: file_event_location,
                                               description: file_event_description,
                                               start: file_date,
                                               category: 1,
                                               logged_units: file_event_duration)

              event.end = file_date + file_event_duration
              event.save
            when 'Camping*'
              event = Event.find_or_create_by!(title: file_event_location,
                                               description: file_event_description,
                                               start: file_date,
                                               category: 2,
                                               logged_units: file_event_duration)

              event.end = file_date + file_event_duration
              event.save
            when 'Serv Proj'
              event = Event.find_or_create_by!(title: file_event_location,
                                               description: file_event_description,
                                               start: file_date,
                                               category: 6,
                                               logged_units: file_event_duration)
            when 'Outng'
              event = Event.find_or_create_by!(title: file_event_location,
                                               description: file_event_description,
                                               start: file_date,
                                               category: 3,
                                               logged_units: file_event_duration)
            when 'Hiking'
              event = Event.find_or_create_by!(title: file_event_location,
                                               description: file_event_description,
                                               start: file_date,
                                               category: 8,
                                               logged_units: file_event_duration)
            else
              Rails.logger.debug "Unable to log #{file_event_type} as an event."

          end
          # Add Scout to event
          ScoutEvent.find_or_create_by(scout_id: scout_id, event_id: event.id)
          i += 1
        end
      end
    end
  end

end
