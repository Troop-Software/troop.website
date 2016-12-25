class ImportScoutJob < ApplicationJob
  queue_as :urgent

  def perform(file_id)
    Scout.import_scout(file_id)
  end
end
