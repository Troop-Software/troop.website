class ImportAdultEventsJob < ApplicationJob
  queue_as :urgent

  def perform(file_id)
    AdultEvent.import_participation(file_id)
  end
end
