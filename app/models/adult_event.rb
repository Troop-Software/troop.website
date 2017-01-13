class AdultEvent < ApplicationRecord
  validates :adult_id, presence: true
  validates :event_id, presence: true
  validates :notes, length: {minimum: 5, maximum: 254}, allow_blank: true
  validates :adult_id, uniqueness: {scope: :event_id, :message => ' is already part of this event'}

  belongs_to :adult
  belongs_to :event

  scope :events_in_60_day_window, -> { joins(:event).where('events.start between ? and ?', 30.days.ago, 30.days.from_now) }
  scope :events_in_year_window, -> { joins(:event).where('events.start between ? and ?', 1.year.ago, 1.year.from_now) }

  def self.import_participation(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url
    file = File.new(open(file, 'r'))

    post_processed_file = []
    while (line = file.gets)
      next if line =~ /\(.\*Cabin Camp.\)/
      next if line =~ /Adult Individual Participation Report/
      next if line =~ /Troop Activities/
      next if line =~ /Patrol:/
      next if line =~ /Current Rank:/
      next if line =~ /Pos'n of Respons/
      next if line =~ /Leadership Pos/
      next if line =~ /Date Joined Unit/
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
        line_adult_name = post_processed_file[i][16..54].strip.split(', ')
        adult_name = "#{line_adult_name.last} #{line_adult_name.first}"
        adult = Adult.find_by_name(adult_name)
        if adult.blank?
          adult = Adult.create(name: adult_name)
        end
        adult_id = adult.id
        i += 1
        until post_processed_file[i] =~ /Name:/ || i >= post_processed_file.count do
          debug_line =  post_processed_file[i]
          file_date = DateTime.strptime("#{post_processed_file[i][0..8]} 09:00 pm", '%m/%d/%y %I:%M %P')
          file_event_type = post_processed_file[i][16..29].strip
          file_event_duration = post_processed_file[i][30..36].strip.to_i
          file_event_location = post_processed_file[i][36..54].strip
          file_event_description = post_processed_file[i][55..80].strip
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
          # Add Adult to event
          AdultEvent.find_or_create_by(adult_id: adult_id, event_id: event.id, attended: true)
          i += 1
        end
      end
    end
  end

end