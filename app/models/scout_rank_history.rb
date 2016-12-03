class ScoutRankHistory < ActiveRecord::Base
  belongs_to :scout
  belongs_to :rank

  accepts_nested_attributes_for :scout

end