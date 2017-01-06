class AdultTraining < ApplicationRecord
  belongs_to :adult
  belongs_to :adult_training_course

  validates :adult_id, presence: true
  validates :adult_training_course_id, presence: true
  validates :completed_date, presence: true


  def self.import_adult_training(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url

    CSV.new(open(file), headers: true).each do |row|
      name = adult_name(row['Nickname'], row['Last Name'])
      # number of training courses take
      (row['Training Course'].blank?) ? num_trainings = 0 : num_trainings = count_trainings(row.size)

      Rails.logger.debug name
      Rails.logger.debug num_trainings

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
