class Requirement < ApplicationRecord
  validates :revision, presence: true
  validates :rank_id, presence: true
  validates :req_category, presence: true
  validates :description, presence: true, length: {minimum: 10, maximum: 250}

  enum req_category: [:general, :camping_and_outdoor_ethics, :cooking, :tools, :first_aid_and_nature, :hiking,
                      :fitness, :citizenship, :leadership, :scout_spirit, :cooking_and_tools, :navigation,
                      :nature, :aquatics, :first_aid, :first_aid_and_emergency_prepardness]

  belongs_to :rank
  has_many :scout_requirements
  has_many :scouts, through: :scout_requirements

  scope :by_rank_id, -> rank_id { where(:rank_id => rank_id) }

end
