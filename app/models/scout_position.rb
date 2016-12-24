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

end
