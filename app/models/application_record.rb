class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :search, -> (search) { where('name like ?', "%#{search}%") }
  scope :search_title, -> (search) { where('title like ?', "%#{search}%") }
end
