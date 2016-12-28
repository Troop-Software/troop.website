class ImportMeritBadgesJob < ApplicationJob
  queue_as :urgent

  def perform(file_id)
    ScoutMeritBadge.import_merit_badges(file_id)
  end
end
