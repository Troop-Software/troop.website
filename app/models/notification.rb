class Notification < ApplicationRecord
  validates :text, presence: true, length: {minimum: 3, maximum: 50}

  def self.to_show
    Notification.where(active: true).where('display_until >= ?', Date.today).order(id: :asc)
  end
end
