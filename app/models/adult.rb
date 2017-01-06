class Adult < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  enum sex: [:male, :female]

  validates :name, presence: true, length: {minimum: 5, maximum: 50}
  # validates :email, presence: true,
  #           length: {maximum: 128},
  #           uniqueness: {case_sensitive: false},
  #           format: {with: VALID_EMAIL_REGEX}

  validates_uniqueness_of :name

  belongs_to :user
  has_many :adult_positions
  has_many :positions, through: :adult_positions
  has_many :adult_trainings
  has_many :adult_training_courses, through: :adult_trainings
  has_many :adult_vehicles
  has_many :vehicles, through: :adult_vehicles
  has_many :adult_events
  has_many :events, through: :adult_events


  def self.import_adult(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url

    CSV.new(open(file), headers: true).each do |row|
      name = adult_name(row['First Name'], row['Last Name'])
      adult_record = Adult.find_or_initialize_by(name: name)
      adult_record.update(name: name,
                          sex: sex(row['Sex (M/F)']),
                          email: row['Email #1'],
                          phone: row['Home Phone'] ,
                          bsa_id: row['BSA ID#'],
                          dob: format_date_for_import(row['Date of Birth']),
                          drivers_license: row['Drivers License'] ,
                          joined: format_date_for_import(row['Joined Unit'])

      )
      #Adult Position
      unless row['Leadership Pos #1'].nil? || Adult.find_by_name(name).blank?
        AdultPosition.find_or_create_by(adult_id: Adult.find_by_name(name).id,
                                        position_id: convert_position(row['Leadership Pos #1']),
                                        start_date: format_date_for_import(row['Leadership Pos Date #1'])
        )
      end
    end
  end

  def self.convert_position(position_name)
    case position_name
      when 'Executive Officer'
        position_name = 'Charter Organization Representative'
      when 'Asst Scoutmaster'
        position_name = 'Assistant Scoutmaster'
    end
    position = Position.find_by_name(position_name)
    position = Position.create(name: position_name, adult_position: true) if position.blank?
    position.id
  end

  def self.format_date_for_import(date)
    return '' if date.blank?
    date = Date.strptime(date, '%m/%d/%Y')
  end

  def self.sex(field)
    return 0 if field.downcase == 'male'
    return 1 if field.downcase == 'female'
    2
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
    expired_after = AdultTrainingCourse.find(training_course).expires_after
    unless expired_after.blank?
      if date_taken < expired_after.years.ago
        return true
      else
        return false
      end
    end
  end

  def ypt_expired?
    ypt_courses = AdultTrainingCourse.where(bsa_code: ['Y01','Y02','Y03']).ids
    ypt_courses_taken = AdultTraining.where(adult_training_course_id: ypt_courses, adult_id: self.id )
    ypt_courses_taken.each do |course|
      Rails.logger.debug course.inspect
      result = self.training_expired?(course.adult_training_course_id, course.completed_date)
      if result != true
        return false
      end
    end
return true
  end
end