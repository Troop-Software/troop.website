class ImportPositionHistoryJob < ApplicationJob
  queue_as :urgent

  def perform(file_id)
    ScoutPosition.import_position_history(file_id)
  end
end
