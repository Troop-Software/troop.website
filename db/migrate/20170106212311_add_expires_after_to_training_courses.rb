class AddExpiresAfterToTrainingCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :adult_training_courses, :expires_after, :integer
  end
end
