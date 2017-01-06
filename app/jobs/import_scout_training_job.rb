class ImportScoutTrainingJob < ApplicationJob
  queue_as :urgent

  def perform(file_id)
    ScoutTraining.import_scout_training(file_id)
  end
end
