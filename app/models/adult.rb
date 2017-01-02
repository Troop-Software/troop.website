class Adult < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {minimum: 5, maximum: 50}
  validates :email, presence: true,
            length: {maximum: 128},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX }

  validates_uniqueness_of :name

  belongs_to :adult_position
  belongs_to :user

  def position_name
    position_name = ''
    position_name = AdultPosition.find(self.adult_position_id).name unless self.adult_position_id.blank?
  end

  def leader?
    case self.position_name
      when 'Scoutmaster'
        leader = true
      when 'Assistant Scoutmaster'
        leader = true
      when 'Committee Chair'
        leader = true
      else
        leader = false
    end
    leader
  end
end