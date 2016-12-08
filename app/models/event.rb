class Event < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :start, presence: true
  validates :category, presence: true
  
  enum category: [:troop_meeting, :campout, :outing, :plc, :committee_meeting, 
                    :service_project, :training, :other]
  
  
  def self.search(search)
    if search
      #search by id
      #where('category LIKE ?', "%#{search}%")
      #seach exact match
      where(category: Event.categories[search.parameterize.underscore.to_sym])
    else
      all
    end
  end
end
