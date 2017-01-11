class ImportAdultPositionHistoryJob < ApplicationJob
  queue_as :urgent

  def perform(file_id)
    AdultPosition.import_adult_history(file_id)
  end
end