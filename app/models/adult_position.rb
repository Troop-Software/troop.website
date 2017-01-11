class AdultPosition < ApplicationRecord
  belongs_to :adult
  belongs_to :position

  validates :adult_id, presence: true
  validates :position_id, presence: true
  validates :start_date, presence: true
  validates_uniqueness_of :adult, scope: [:position_id, :start_date], message: '- There is a record that matches this already.'

  def current_position?
    return false if self.position_id == 1 # Do not consider "None" to be a current position
    (self.end_date.nil? || Date.today.between?(self.start_date, self.end_date)) ? true : false
  end

  def self.import_adult_history(file_id)
    file ='https:' + Admin::FileUpload.find(file_id).file.url

    CSV.new(open(file), headers: true).each do |row|
      adult = Adult.find_or_initialize_by(name: row['Name'])
      next if adult.blank?
      position = Position.find_by(name: row['Position'])
      next if position.blank?
      adult_position = AdultPosition.find_or_initialize_by(adult_id: adult,
                                                           position_id: position,
                                                           start_date: Date.strptime(row['Start'], '%m/%d/%Y')
      )
      adult_position.update(adult_id: adult.id,
                            position_id: position.id,
                            start_date: Date.strptime(row['Start'], '%m/%d/%Y'),
                            end_date: Date.strptime(row['End'], '%m/%d/%Y')
      )
    end
  end

end