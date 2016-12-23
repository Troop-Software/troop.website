class ScoutRequirement < ActiveRecord::Base
  validates :completed_date, presence: true
  belongs_to :scout
  belongs_to :requirement

  accepts_nested_attributes_for :requirement

end