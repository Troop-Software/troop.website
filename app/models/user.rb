class User < ApplicationRecord
  include Storext.model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :zxcvbnable, :confirmable if Rails.configuration.troop_website.confirm_signup


  has_many :articles
  has_many :assignments
  has_many :roles, through: :assignments
  has_many :relationships
  has_many :scouts, through: :relationships
  has_many :adults

  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 25}
  validates :email, presence: true,
            length: {maximum: 128},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX }

  store_attributes :settings do
    show_inactive_scouts Boolean, default: false
  end

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def registered_adult?
    adult_record = Adult.find_by(user_id: self.id)
    adult_record.blank? ?  false :  true
  end

end
