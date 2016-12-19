class StaticPages < ActiveRecord::Base

  scope :search, -> (search) { where('title like ?', "%#{search}%") }
end