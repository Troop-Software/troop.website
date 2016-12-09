class ScoutRequirement < ActiveRecord::Base
  belongs_to :scout
  belongs_to :requirement

  accepts_nested_attributes_for :requirement

  after_create :mark_rank_completed_after_bor
  
  def mark_rank_completed_after_bor
    if requirement.bor
      mark_rank = ScoutRankHistory.new(scout_id: scout_id, rank_id: requirement.rank_id )
      mark_rank.rank_completed = self.completed_date
      mark_rank.save
    end
  end  
end