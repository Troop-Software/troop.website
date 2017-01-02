class Adult < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  enum sex: [:male, :female]

  validates :name, presence: true, length: {minimum: 5, maximum: 50}
  validates :email, presence: true,
            length: {maximum: 128},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX }

  validates_uniqueness_of :name

  belongs_to :user
  has_many :adult_positions
  has_many :positions, through: :adult_positions


end