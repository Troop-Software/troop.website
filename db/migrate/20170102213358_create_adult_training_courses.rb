class CreateAdultTrainingCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :adult_training_courses do |t|
      t.string :name
      t.string :bsa_code
      t.date :expired
    end
  end
end
