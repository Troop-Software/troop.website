class AdultTraining < ApplicationRecord
  belongs_to :adult
  belongs_to :adult_training_course

  validates :adult_id, presence: true
  validates :adult_training_course_id, presence: true
  validates :completed_date, presence: true


  def self.import_ypt_aging_details(file_id)

    require 'open-uri'
    require 'pdf/reader'

    file = open('https:' + Admin::FileUpload.find(file_id).file.url)
    reader = PDF::Reader.new(file)
    post_processed_file = []
    reader.pages.each do |page|
      lines = page.text.scan(/^.+/)
      lines.each do |line|
        next if line =~ /YOUTH PROTECTION TRAINING AGING REPORT/
        next if line =~ /Adult Members/
        next if line =~ /Council:/
        next if line =~ /Unit:/
        next if line =~ /\s{20}/
        next if line =~ /Count Summary/
        next if line =~ /\*\*Dashboard data/
        next if line =~ /Expires 31/
        next if line =~ /Total:/
        next if line =~ /Executive Officer/
        next if line =~ /are not reflected/
        post_processed_file << line.strip
      end
    end
    ap post_processed_file
    post_processed_file.each do |line|
      file_name = line[0..28].strip # Name
      first_name = file_name.split(' ')[0]

      case file_name.split.last.downcase
        when 'jr', 'sr', 'iii', 'ii', 'iv'
          last_name = file_name.split(' ')[-2]
        else
          last_name = file_name.split.last
      end
      ap full_name = [first_name, last_name].reject(&:empty?).join(' ')
      adult_record = Adult.find_by_name(full_name)
      if adult_record.blank?
        adult_record = Adult.where("name LIKE ?", "%#{last_name}%").first
        if adult_record.blank?
          next
        end
      end
      training_course = line[29..58].strip # Training
      case training_course
        when 'Youth Protection Training'
          training_id = AdultTrainingCourse.find_by_bsa_code('Y01').id
        when 'Venturing Youth Protection'
          training_id = AdultTrainingCourse.find_by_bsa_code('Y02').id
        when 'Exploring Youth Protection'
          training_id = AdultTrainingCourse.find_by_bsa_code('Y03').id
        else
          next
      end
      ap training_id
      # expire_range = line[59..82].strip # Expire range (not imported)
      course_date = Date.strptime(line[83..92].strip, "%m/%d/%Y") # Date Taken
      # date_expires = line[102..112].strip # Date Expires (not imported)
      result = AdultTraining.find_or_create_by(adult_id: adult_record.id,
                                               adult_training_course_id: training_id,
                                               completed_date: course_date)
      ap result
    end
  end

  def self.import_adult_training(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url

    CSV.new(open(file), headers: true).each do |row|
      name = adult_name(row['Nickname'], row['Last Name'])
      # number of training courses take
      (row['Training Course'].blank?) ? num_trainings = 0 : num_trainings = count_trainings(row.size)

      adult = Adult.find_by_name(name)
      next if adult.blank?
      next if num_trainings == 0 # nothing to import
      row_number = 4
      num_trainings.times do
        # training_name = row[row_number][0...-6].chomp
        training_code = row[row_number+1]
        training_date = Date.strptime(row[row_number+2], '%m/%d/%Y')

        course = AdultTrainingCourse.find_by_bsa_code(training_code)
        unless course.blank?
          AdultTraining.find_or_create_by(adult_id: adult.id,
                                          adult_training_course_id: course.id,
                                          completed_date: training_date)
        end
        row_number +=3
      end
    end
  end

  def self.count_trainings(size_of_row)
    # remove # of invaild columns (name etc)
    size_of_row -= 4
    # 3 columns per training
    size_of_row / 3
  end

  def self.adult_name(first, last)
    name = ''
    name += first unless first.nil?
    #name += " #{middle}" unless middle.nil?
    name += " #{last}" unless last.nil?
    #name += " #{suffix}" unless suffix.nil?
    return name
  end

  def training_expired?(training_course, date_taken)
    expired_after = AdultTrainingCourse.find(training_course.id).expires_after
    unless expired_after.blank?
      if date_taken < expired_after.years.ago
        return true
      else
        return false
      end
    end
  end


end
