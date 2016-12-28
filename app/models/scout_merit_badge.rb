class ScoutMeritBadge < ApplicationRecord
  belongs_to :scout
  belongs_to :merit_badge

  def self.import_merit_badges(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url
    file = File.new(open(file, 'r'))

    post_processed_file = []
    # Strip Junk from file to make it easier to parse
    while (line = file.gets)
      next if line =~ /^\d+\/\d+\/\d+/ # Date file Generated
      next if line =~ /\s+Merit Badges Earned/ # Report Title
      next if line.blank? # Blank Line
      next if line =~ /\(Page/
      next if line =~ /\(cont\)/
      post_processed_file << line
    end
    scout_mb_record = []
    i = 0
    while i < post_processed_file.count do

      if post_processed_file[i] =~ /Rank/
        @scout_record = {}
        line_scout_name = post_processed_file[i][0..29].strip.split(', ')
        @scout_record[:scout_name] = "#{line_scout_name.last} #{line_scout_name.first}"
        @scout_record[:rank] = post_processed_file[i][36..55].strip
        @scout_record[:total] = post_processed_file[i][68..71].strip.to_i
        @scout_record[:merit_badge] = {}
        i += 1
        until post_processed_file[i] =~ /Rank/ || post_processed_file[i].blank? do
          process_merit_badge(post_processed_file[i])
          i += 1
        end
        scout_mb_record << @scout_record
      end
    end
    # Logic to add data to database
    scout_mb_record.each do |record|
      scout = Scout.find_by_name(record[:scout_name])
      if scout.nil?
        Delayed::Worker.logger.warn "Scout not found: #{record[:scout_name]}"
        next
      end
      record[:merit_badge].each do |merit_badge|
        #Rails.logger.debug merit_badge[0]
        merit_badge_clean = merit_badge[0].sub('#','')
        mb = MeritBadge.find_by_name(merit_badge_clean)
        if mb.nil?
          mb = MeritBadge.find_by_short_name(merit_badge_clean)
          if mb.nil?
            Delayed::Worker.logger.warn "Merit badge not found: #{merit_badge_clean}, adding as a legacy MB."
            MeritBadge.create(name: merit_badge_clean , current: false, eagle_required: false)
            mb = MeritBadge.find_by_name(merit_badge_clean)
          end
        end
        scout_mb_db_record = ScoutMeritBadge.find_or_initialize_by(scout_id: scout.id, merit_badge_id: mb.id )
        scout_mb_db_record.update(completed: mb[1])
      end
    end
  end


  def self.parse_merit_badge(name, date)
    unless date.blank?
      name.delete! '*'
      @scout_record[:merit_badge][name.strip] = Date.strptime(date, '%m/%d/%y')
    end
  end

  def self.process_merit_badge(line)
    parse_merit_badge(line[0..19], line[20..27])
    parse_merit_badge(line[29..48], line[49..56])
    parse_merit_badge(line[58..77], line[78..85])
  end


end
