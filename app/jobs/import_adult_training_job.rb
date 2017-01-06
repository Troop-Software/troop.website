class ImportAdultTrainingJob < ApplicationJob
  queue_as :urgent

  def perform(file_id)
    AdultTraining.import_adult_training(file_id)
  end
end
