class ImportAdultJob < ApplicationJob
  queue_as :urgent

  def perform(file_id)
    Adult.import_adult(file_id)
  end
end