class Scout < ApplicationRecord
  validates :name, presence: true, length: {minimum: 3, maximum: 50}
  validates_numericality_of :grade,
                            :less_than_or_equal_to => 12,
                            :greater_than_or_equal_to => 5,
                            :only_integer => true
  #validates :patrol_id, presence: true
  belongs_to :patrol
  belongs_to :rank
  belongs_to :position


  def age(birthday)
    # http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
    (Time.now.to_s(:number).to_i - birthday.to_time.to_s(:number).to_i)/10e9.to_i
  end

  def age_out_date(birthday)
    birthday + 18.years
  end

  def days_till_18(birthday)
    (age_out_date(birthday) - Date.today).to_i
  end

  def scout_alert

    # Set Red if less than 180 left till 18 and rank is Life
    return ['alert-danger','Less than 3 months till 18th birthday'] if self.rank.name == 'Life' and days_till_18(self.birthdate).between?(0, 180)

    # Set Yellow if less than 274 left and rank is Life
    return ['alert-warning','Less than 9 months till 18th birthday'] if self.rank.name == 'Life' and days_till_18(self.birthdate).between?(181, 274)

    return nil


  end

end
