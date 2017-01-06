class ScoutTraining < ApplicationRecord
  belongs_to :scout
  belongs_to :youth_training

  validates :scout_id, presence: true
  validates :youth_training_id, presence: true
  validates :completed_date, presence: true

  def self.import_scout_training(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url

    CSV.new(open(file), headers: true).each do |row|
      name = scout_name(row['Nickname'], row['Last Name'])
      # number of training courses take
      (row['Training Course'].blank?) ? num_trainings = 0 : num_trainings = count_trainings(row.size)

      Rails.logger.debug name
      Rails.logger.debug num_trainings

      scout = Scout.find_by_name(name)
      next if scout.blank?
      next if num_trainings == 0 # nothing to import
      row_number = 4
      num_trainings.times do
        training_name = row[row_number]
        training_date = Date.strptime(row[row_number+1], '%m/%d/%Y')

        course = YouthTraining.find_or_create_by(name: training_name)
        unless course.blank?
          ScoutTraining.find_or_create_by(scout_id: scout.id,
                                          youth_training_id: course.id,
                                          completed_date: training_date)
        end
        row_number +=2
      end
    end
  end

  def self.count_trainings(size_of_row)
    # remove # of invaild columns (name etc)
    size_of_row -= 4
    # 3 columns per training
    size_of_row / 2
  end

  def self.scout_name(first, last)
    name = ''
    name += first unless first.nil?
    #name += " #{middle}" unless middle.nil?
    name += " #{last}" unless last.nil?
    #name += " #{suffix}" unless suffix.nil?
    return name
  end
end

