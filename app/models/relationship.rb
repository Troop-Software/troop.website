class Relationship < ApplicationRecord
  belongs_to :scout
  belongs_to :user

  scope :user_sort, -> { includes(:user).order('users.username') }

end