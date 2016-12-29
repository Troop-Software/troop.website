class ScoutPosition < ApplicationRecord
  belongs_to :scout
  belongs_to :position

  validates :scout_id, presence: true
  validates :position_id, presence: true
  validates :start_date, presence: true
  validates_uniqueness_of :scout, scope: [:position_id, :start_date], message: '- There is a record that matches this already.'

  def current_position?
    return false if self.position_id == 1 # Do not consider "None" to be a current position
    (self.end_date.nil? || Date.today.between?(self.start_date, self.end_date)) ? true : false
  end

  def self.import_position_history(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url
    file = File.new(open(file, 'r'))

    post_processed_file = []
    while (line = file.gets)
      next if line =~ /^\d+\/\d+\/\d+/
      next if line =~ /Individual History Report/
      next if line.blank?
      next if line =~ /Patrol:/
      next if line =~ /Current Rank:/
      next if line =~ /Date Joined Unit:/
      next if line =~ /Leadership History/
      next if line =~ /\d+\/\d+\/\d+\s{54}/
      next if line =~ /Completed Ranks/
      post_processed_file << line
    end

    i = 0
    while i < post_processed_file.count do
      if post_processed_file[i] =~ /Name:/
        line_scout_name = post_processed_file[i][16..54].strip.split(', ')
        scout_name = "#{line_scout_name.last} #{line_scout_name.first}"
        i += 1
        until post_processed_file[i] =~ /Name:/ || i >= post_processed_file.count do
          line = post_processed_file[i].strip
          Rails.logger.debug line.inspect
          line_breakdown= (line.split('  ') - ['', nil]).map(&:lstrip)
          Rails.logger.debug line_breakdown


          position = Scout.convert_position(line_breakdown[0])
          position_dates = line_breakdown[1].split(' - ')
          position_start_date = Date.strptime(position_dates[0], '%m/%d/%y')
          position_end_date = Date.strptime(position_dates[1], '%m/%d/%y')
          ScoutPosition.find_or_create_by(scout_id: Scout.find_by_name(scout_name).id,
                                          position_id: Position.find_by_name(position).id,
                                          start_date: position_start_date,
                                          end_date: position_end_date)
          if line_breakdown.size == 4
            position = Scout.convert_position(line_breakdown[2])
            position_dates = line_breakdown[3].split(' - ')
            position_start_date = Date.strptime(position_dates[0], '%m/%d/%y')
            position_end_date = Date.strptime(position_dates[1], '%m/%d/%y')
            ScoutPosition.find_or_create_by(scout_id: Scout.find_by_name(scout_name).id,
                                            position_id: Position.find_by_name(position).id,
                                            start_date: position_start_date,
                                            end_date: position_end_date)

          end

          i += 1
        end
      end
    end
  end
end